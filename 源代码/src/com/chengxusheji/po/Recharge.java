package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Recharge {
    /*充值id*/
    private Integer rechargeId;
    public Integer getRechargeId(){
        return rechargeId;
    }
    public void setRechargeId(Integer rechargeId){
        this.rechargeId = rechargeId;
    }

    /*充值用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*充值金额*/
    @NotNull(message="必须输入充值金额")
    private Float rechargeMoney;
    public Float getRechargeMoney() {
        return rechargeMoney;
    }
    public void setRechargeMoney(Float rechargeMoney) {
        this.rechargeMoney = rechargeMoney;
    }

    /*充值备注*/
    private String rechargeMemo;
    public String getRechargeMemo() {
        return rechargeMemo;
    }
    public void setRechargeMemo(String rechargeMemo) {
        this.rechargeMemo = rechargeMemo;
    }

    /*充值时间*/
    private String rechargeTime;
    public String getRechargeTime() {
        return rechargeTime;
    }
    public void setRechargeTime(String rechargeTime) {
        this.rechargeTime = rechargeTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonRecharge=new JSONObject(); 
		jsonRecharge.accumulate("rechargeId", this.getRechargeId());
		jsonRecharge.accumulate("userObj", this.getUserObj().getName());
		jsonRecharge.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonRecharge.accumulate("rechargeMoney", this.getRechargeMoney());
		jsonRecharge.accumulate("rechargeMemo", this.getRechargeMemo());
		jsonRecharge.accumulate("rechargeTime", this.getRechargeTime().length()>19?this.getRechargeTime().substring(0,19):this.getRechargeTime());
		return jsonRecharge;
    }}