package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Product {
    /*商品id*/
    private Integer productId;
    public Integer getProductId(){
        return productId;
    }
    public void setProductId(Integer productId){
        this.productId = productId;
    }

    /*商品类别*/
    private ProductClass productClassObj;
    public ProductClass getProductClassObj() {
        return productClassObj;
    }
    public void setProductClassObj(ProductClass productClassObj) {
        this.productClassObj = productClassObj;
    }

    /*商品名称*/
    @NotEmpty(message="商品名称不能为空")
    private String productName;
    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }

    /*商品图片*/
    private String mainPhoto;
    public String getMainPhoto() {
        return mainPhoto;
    }
    public void setMainPhoto(String mainPhoto) {
        this.mainPhoto = mainPhoto;
    }

    /*商品库存*/
    @NotNull(message="必须输入商品库存")
    private Integer productNum;
    public Integer getProductNum() {
        return productNum;
    }
    public void setProductNum(Integer productNum) {
        this.productNum = productNum;
    }

    /*商品价格*/
    @NotNull(message="必须输入商品价格")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*是否推荐*/
    @NotEmpty(message="是否推荐不能为空")
    private String recommandFlag;
    public String getRecommandFlag() {
        return recommandFlag;
    }
    public void setRecommandFlag(String recommandFlag) {
        this.recommandFlag = recommandFlag;
    }

    /*是否特价*/
    @NotEmpty(message="是否特价不能为空")
    private String recipeFlag;
    public String getRecipeFlag() {
        return recipeFlag;
    }
    public void setRecipeFlag(String recipeFlag) {
        this.recipeFlag = recipeFlag;
    }

    /*商品描述*/
    @NotEmpty(message="商品描述不能为空")
    private String productDesc;
    public String getProductDesc() {
        return productDesc;
    }
    public void setProductDesc(String productDesc) {
        this.productDesc = productDesc;
    }

    /*发布时间*/
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonProduct=new JSONObject(); 
		jsonProduct.accumulate("productId", this.getProductId());
		jsonProduct.accumulate("productClassObj", this.getProductClassObj().getClassName());
		jsonProduct.accumulate("productClassObjPri", this.getProductClassObj().getClassId());
		jsonProduct.accumulate("productName", this.getProductName());
		jsonProduct.accumulate("mainPhoto", this.getMainPhoto());
		jsonProduct.accumulate("productNum", this.getProductNum());
		jsonProduct.accumulate("price", this.getPrice());
		jsonProduct.accumulate("recommandFlag", this.getRecommandFlag());
		jsonProduct.accumulate("recipeFlag", this.getRecipeFlag());
		jsonProduct.accumulate("productDesc", this.getProductDesc());
		jsonProduct.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonProduct;
    }}