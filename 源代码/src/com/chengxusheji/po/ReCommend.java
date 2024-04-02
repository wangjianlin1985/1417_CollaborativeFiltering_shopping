package com.chengxusheji.po;

public class ReCommend {
	/*记录id*/
    private Integer recommendId;
    /*用户id*/
    private String userId;
    /*物品id*/
    private String itemId;
    /*推荐权重*/
    private double weight;
	public Integer getRecommendId() {
		return recommendId;
	}
	public void setRecommendId(Integer recommendId) {
		this.recommendId = recommendId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public double getWeight() {
		return weight;
	}
	public void setWeight(double weight) {
		this.weight = weight;
	}
    
   
}
