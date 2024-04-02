package com.chengxusheji.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Product;

public interface ProductMapper {
	/*添加商品信息*/
	public void addProduct(Product product) throws Exception;

	/*按照查询条件分页查询商品记录*/
	public ArrayList<Product> queryProduct(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有商品记录*/
	public ArrayList<Product> queryProductList(@Param("where") String where) throws Exception;

	/*根据用户id获取推荐物品列表*/ 
	public ArrayList<Product> queryRecommendProductList(@Param("where") String where) throws Exception;

	/*查询相似物品列表*/
	public ArrayList<Product> querySimilarProductList(@Param("where") String where);
	
	
	/*按照查询条件的商品记录数*/
	public int queryProductCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条商品记录*/
	public Product getProduct(int productId) throws Exception;

	/*更新商品记录*/
	public void updateProduct(Product product) throws Exception;

	/*删除商品记录*/
	public void deleteProduct(int productId) throws Exception;

	
	
	

}
