<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.Comment" %>
<%@ page import="com.chengxusheji.po.ProductClass" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的productClassObj信息
    List<ProductClass> productClassList = (List<ProductClass>)request.getAttribute("productClassList");
    Product product = (Product)request.getAttribute("product");
    List<Comment> commentList = (ArrayList<Comment>)request.getAttribute("commentList");
    List<Product> productList = (List<Product>)request.getAttribute("similarProductList");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>查看商品详情</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li><a href="<%=basePath %>Product/frontlist">商品信息</a></li>
  		<li class="active">详情查看</li>
	</ul>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品id:</div>
		<div class="col-md-10 col-xs-6"><%=product.getProductId()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品类别:</div>
		<div class="col-md-10 col-xs-6"><%=product.getProductClassObj().getClassName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品名称:</div>
		<div class="col-md-10 col-xs-6"><%=product.getProductName()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品图片:</div>
		<div class="col-md-10 col-xs-6"><img class="img-responsive" src="<%=basePath %><%=product.getMainPhoto() %>"  border="0px"/></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品库存:</div>
		<div class="col-md-10 col-xs-6"><%=product.getProductNum()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品价格:</div>
		<div class="col-md-10 col-xs-6"><%=product.getPrice()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">是否推荐:</div>
		<div class="col-md-10 col-xs-6"><%=product.getRecommandFlag()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">是否特价:</div>
		<div class="col-md-10 col-xs-6"><%=product.getRecipeFlag()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品描述:</div>
		<div class="col-md-10 col-xs-6"><%=product.getProductDesc()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">发布时间:</div>
		<div class="col-md-10 col-xs-6"><%=product.getAddTime()%></div>
	</div>
	
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">评论内容:</div>
		<div class="col-md-10 col-xs-6">
			<textarea id="content" style="width:100%" rows=8></textarea>
		</div>
	</div>
	
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="userComment();" class="btn btn-primary">发布评论</button>
			<button onclick="cartAdd();" class="btn btn-primary">加入购物车</button>
			<button onclick="history.back();" class="btn btn-info">返回</button>
		</div>
	</div>
	
	
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold"></div>
		<div class="col-md-8 col-xs-7">
			<% for(Comment comment: commentList) { %>
			<div class="row" style="margin-top: 20px;">
				<div class="col-md-2 col-xs-3">
					<div class="row text-center"><img src="<%=basePath %><%=comment.getUserObj().getUserPhoto() %>" style="border: none;width:60px;height:60px;border-radius: 50%;" /></div>
					<div class="row text-center" style="margin: 5px 0px;"><%=comment.getUserObj().getUser_name() %></div>
				</div>
				<div class="col-md-7 col-xs-5"><%=comment.getContent() %></div>
				<div class="col-md-3 col-xs-4" ><%=comment.getCommentTime() %></div>
			</div>
		
			<% } %> 
		</div>
	</div>
	
	<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Product/frontlist">商品信息列表</a></li>
  			<li class="active" style="color:red;">相似商品推荐</li>
  			 
		</ul>
	
	<div class="row">
			<%
				if(productList != null) {
					/*遍历记录*/
					for(int i=0;i<productList.size();i++) {
	            		int currentIndex = i + 1; //当前记录的序号
	            		Product similarProduct = productList.get(i); //获取到商品对象
	            		String clearLeft = "";
	            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Product/<%=similarProduct.getProductId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=similarProduct.getMainPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		商品类别:<%=similarProduct.getProductClassObj().getClassName() %>
			     	</div>
			     	<div class="field">
	            		商品名称:<%=similarProduct.getProductName() %>
			     	</div>
			     	<div class="field">
	            		商品库存:<%=similarProduct.getProductNum() %>
			     	</div>
			     	<div class="field">
	            		商品价格:<%=product.getPrice() %>
			     	</div>
			     	<div class="field">
	            		是否推荐:<%=product.getRecommandFlag() %>
			     	</div>
			     	<div class="field">
	            		是否特价:<%=product.getRecipeFlag() %>
			     	</div>
			     	<div class="field">
	            		发布时间:<%=similarProduct.getAddTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Product/<%=similarProduct.getProductId() %>/frontshow">详情</a>
			     </div>
			</div>
			<%		} %>
			<%  } %>

			 
		</div>
		
	
</div>

		
<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script>
var basePath = "<%=basePath%>";
$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
 })
 
 
 function cartAdd() {
	$.ajax({
		url : basePath + "ShopCart/userAdd",
		type : "post",
		data: {
			"shopCart.productObj.productId": <%=product.getProductId() %>, 
		},
		success : function (data, response, status) {
			//var obj = jQuery.parseJSON(data);
			if(data.success){
				alert("购物车添加成功~");
				location.href = basePath + "ShopCart/userFrontlist";
			}else{
				alert(data.message);
			}
		}
	});
}

function userComment() {
	var content = $("#content").val();
	if(content == "") {
		alert("请输入评论内容");
		return;
	}

	$.ajax({
		url : basePath + "Comment/userAdd",
		type : "post",
		data: {
			"comment.productObj.productId": <%=product.getProductId() %>,
			"comment.content": content
		},
		success : function (data, response, status) {
			//var obj = jQuery.parseJSON(data);
			if(data.success){
				alert("评论成功~");
				location.reload();
			}else{
				alert(data.message);
			}
		}
	});
}

 </script> 
</body>
</html>

