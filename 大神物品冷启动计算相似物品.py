import pymysql
import pandas as pd
import numpy as np
import re
from gensim.models import TfidfModel
import gensim, logging
from gensim.models.doc2vec import Doc2Vec, TaggedDocument
import jieba
from functools import reduce
import collections

# 获取mysql的连接
conn = pymysql.connect(
    host="127.0.0.1",  # 需要连接的数据库的ip
    port=3306,
    user="root",  # 数据库用户名
    password="123456",  # 数据库密码
    database="gouwuwang_db",  # 需要查询的数据库名
)

def remove_punctuation(text):
    '''删除标点符号和空格'''
    # return re.sub('[^\w\s]', '', text)
    text = re.sub(' ', '', text)
    text = re.sub('[^\w\s]', '', text)
    return text


def remove_html_tags(text):
    text = re.sub('&nbsp;', '', text)
    clean = re.compile('<.*?>')
    return re.sub(clean, '', text)


# 设置 Pandas 打印选项
pd.set_option('display.max_rows', None)  # 显示所有行
pd.set_option('display.max_columns', None)  # 显示所有列
pd.set_option('display.width', None)  # 不折叠单元格
#pd.set_option('display.max_colwidth', None)  # 显示完整的单元格内容

'''
- 查询mysql数据库加载物品相关表的数据
- 利用jieba分词物品的描述字段和分类字段，
- 并将物品的分类词和描述分词作为物品的标签
'''
def get_item_dataset():
    query_sql = "SELECT t_product.productId as itemId,t_product.productName as title,t_productclass.className as genres,t_product.productDesc as itemDesc FROM t_product inner join t_productclass on t_productclass.classId = t_product.productClassObj"
    items_df = pd.read_sql_query(query_sql,conn,index_col="itemId")

    items_df["itemDesc"] = items_df["itemDesc"].apply(lambda x: remove_html_tags(x))
    items_df["itemDesc"] = items_df["itemDesc"].apply(lambda x: remove_punctuation(x))
    items_df["itemDesc"] = items_df["itemDesc"].apply(lambda x: list(jieba.cut(x)))
    # 将类别词分开
    items_df["genres"] = items_df["genres"].apply(lambda x: x.split("|"))

    # 构建数据集，包含Id、标题、类别、标签四个字段
    # 如果没有标签数据，那么就替换为空列表
    # map(fun,可迭代对象)
    item_dataset = pd.DataFrame(
        map(
            lambda x: (x[0], x[1], x[2], x[2] + x[3]) if x[3] is not np.nan else (x[0], x[1], x[2], []),
            items_df.itertuples())
        , columns=["itemId", "title", "genres", "tags"]
    )
    item_dataset.set_index("itemId", inplace=True)
    return item_dataset


'''
- 利用物品表中每个Item的描述分词标签作为物品的候选关键词
- 利用TF·IDF计算每部个的标签的tfidf值，选取TOP-N个关键词作为物品画像标签
- 并将物品的分类词直接作为每个物品的画像标签
'''
def create_item_profile(item_dataset):
    '''
    使用tfidf，分析提取topn关键词
    :param movie_dataset:
    :return:
    '''
    dataset = item_dataset["tags"].values

    from gensim.corpora import Dictionary
    # 根据数据集建立词袋，并统计词频，将所有词放入一个词典，使用索引进行获取
    dct = Dictionary(dataset)
    # 根据将每条数据，返回对应的词索引和词频
    corpus = [dct.doc2bow(line) for line in dataset]
    # 训练TF-IDF模型，即计算TF-IDF值
    model = TfidfModel(corpus)

    _item_profile = []
    for i, data in enumerate(item_dataset.itertuples()):
        itemId = data[0]
        title = data[1]
        genres = data[2]
        # 得到每个电影标签的每个词语的词典索引和权重，类似[(0, 0.17342978500637887), (1, 0.21562355612017706), (2, 0.21205621229134275), (3, 0.1335891911679789), (4, 0.2004362408431816), (5, 0.34531665530514855), (6, 0.837374709121301)]
        vector = model[corpus[i]]
        #按照TF - IDF值得到top - n的关键词
        item_tags = sorted(vector, key=lambda x: x[1], reverse=True)[:30]
        topN_tags_weights = dict(map(lambda x: (dct[x[0]], x[1]), item_tags))
        # 将类别词的添加进去，并设置权重值为1.0
        for g in genres:
            topN_tags_weights[g] = 1.0
        topN_tags = [i[0] for i in topN_tags_weights.items()]
        _item_profile.append((itemId, title, topN_tags, topN_tags_weights))

    item_profile = pd.DataFrame(_item_profile, columns=["itemId", "title", "profile", "weights"])
    item_profile.set_index("itemId", inplace=True)
    return item_profile

#获取物品数据集
item_dataset = get_item_dataset()
print(item_dataset.head())
print("*"*200)
#计算物品画像
item_profile = create_item_profile(item_dataset)
print("物品画像：",item_profile.head())
print("*"*200)

logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
sentences = list(item_profile["profile"].values)
#model = gensim.models.Word2Vec(sentences, window=3, min_count=1, iter=20)
model = gensim.models.Word2Vec(sentences, window=3, min_count=1, epochs=20)
#words = input("请输入你感兴趣的词语: ")  # action
#ret = model.wv.most_similar(positive=[words], topn=10)
#print(ret)
print("物品记录数：",len(item_profile["profile"]))
documents = [TaggedDocument(words, [itemId]) for itemId, words in item_profile["profile"].iteritems()]
#documents = [TaggedDocument(words, [itemId]) for itemId, words in item_dataset["tags"].iteritems()]
# 训练模型并保存
model = Doc2Vec(documents, vector_size=100, window=3, min_count=1, workers=4, epochs=20)
from gensim.test.utils import get_tmpfile
fname = get_tmpfile("my_doc2vec_model")
model.save(fname)

cursor = conn.cursor()
cursor.execute('delete from t_similar_item')
conn.commit()

for item_id, row in item_profile.iterrows():
    words= row["profile"]
    inferred_vector = model.infer_vector(words)
    sims = model.docvecs.most_similar([inferred_vector], topn=4) #找出3个相似物品
    print(sims)
    for sim in sims:
        similar_item_id = sim[0]
        similar = sim[1]
        if item_id != similar_item_id and similar_item_id !=0:
            data = (item_id, similar_item_id, similar)
            cursor.execute("INSERT INTO t_similar_item(item_id, similar_item_id, similar) VALUES (%s, %s, %s)", data)
        conn.commit()

# 关闭游标
cursor.close()
conn.close()



#words = item_profile["profile"].loc[1]
#words = item_dataset["tags"].loc[1]
#print(words)
#inferred_vector = model.infer_vector(words)
#print(inferred_vector)
#sims = model.docvecs.most_similar([inferred_vector], topn=10)
#print("物品1最相似的物品：",sims)


