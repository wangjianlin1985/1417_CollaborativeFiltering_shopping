<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.ProductClass" %>
<jsp:include page="../check_user_logstate.jsp"/>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Product> productList = (List<Product>)request.getAttribute("productList");
    //获取所有的productClassObj信息
    List<ProductClass> productClassList = (List<ProductClass>)request.getAttribute("productClassList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>商品查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Product/frontlist">商品信息列表</a></li>
  			<li class="active" style="color:red;">你可能喜欢的商品</li>
  			 
		</ul>
		<div class="row">
			<%
				if(productList != null) {
					/*遍历记录*/
					for(int i=0;i<productList.size();i++) {
	            		int currentIndex = i + 1; //当前记录的序号
	            		Product product = productList.get(i); //获取到商品对象
	            		String clearLeft = "";
	            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Product/<%=product.getProductId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=product.getMainPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		商品类别:<%=product.getProductClassObj().getClassName() %>
			     	</div>
			     	<div class="field">
	            		商品名称:<%=product.getProductName() %>
			     	</div>
			     	<div class="field">
	            		商品库存:<%=product.getProductNum() %>
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
	            		发布时间:<%=product.getAddTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Product/<%=product.getProductId() %>/frontshow">详情</a>
			     </div>
			</div>
			<%		} %>
			<%  } %>

			 
		</div>
	</div>

	 

		</div>
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script> 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

    /*发布时间组件*/
    $('.product_addTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

