<%@ page import="java.util.ArrayList" %>
<%@ page import="com.itany.zshop.pojo.Product" %>
<%@ page import="com.itany.zshop.pojo.Order" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>我的购物车</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script>
        //删除购物车中的单个
        function deleteone(i,test) {
            if (test==true)
                $.post(
                    '${pageContext.request.contextPath}/front/sessions/deleteSession',
                    {'i':i},
                    function (result) {
                        if (result.status==1)
                            location.href='${pageContext.request.contextPath}/front/sessions/cart?page=3';
                    }
                );
        }
        //删除购物车中的所有
        function deleteAll(test) {
            if (test){
                $.post(
                    '${pageContext.request.contextPath}/front/sessions/deleteAll',
                    function (result) {
                        if (result.status==1)
                            location.href='${pageContext.request.contextPath}/front/sessions/cart?page=3';
                    }
                );
            }
        }
        //增加数量改变价格
        function changePrice(i,price,number) {
            document.getElementById('price'+i).innerHTML=number*price;
            $.post(
                '${pageContext.request.contextPath}/front/sessions/changePrice',
                {'i':i,'number':number},
                function(result) {
                    location.href='${pageContext.request.contextPath}/front/sessions/cart?page=3';
                }
            )
        }
        //提交订单，结算
        function submits() {
            $.post(
                '${pageContext.request.contextPath}/front/Orders/addOrder',
                function (result) {
                    if (result.status!=1)
                        alert(result.message);
                    else
                        location.href='${pageContext.request.contextPath}/front/Orders/findAll?page=2';
                }
            );
        }
    </script>
</head>

<body>
    <div class="navbar navbar-default clear-bottom">
        <div class="container">
            <!-- navbar start -->
            <jsp:include page="top.jsp"/>
            <!-- navbar end -->
        </div>
    </div>
    <!-- content start -->
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <div class="page-header" style="margin-bottom: 0px;">
                    <h3>我的购物车</h3>
                </div>
            </div>
        </div>
        <table class="table table-hover table-striped table-bordered">
            <tr>
                <th>序号</th>
                <th>商品名称</th>
                <th>商品图片</th>
                <th>商品数量</th>
                <th>商品总价</th>
                <th>操作</th>
            </tr>
            <%
                double allprice=(double)0;
                if (session.getAttribute("orders")==null){
                    session.setAttribute("orders",new ArrayList<Order>());
                }
                ArrayList<Order> products=(ArrayList<Order>)session.getAttribute("orders");
                out.println(products.size());
                for (int i=0;i<products.size();i++){
             %>
              <tr>
                <td><%=i+1%></td>
                <td><%=products.get(i).getName()%></td>
                <td> <img src="http://${pageContext.request.serverName}:9001<%=products.get(i).getImage()%>" alt="" width="60" height="60"></td>
                <td>
                    <input type="number" min="1" max="99" value="<%=products.get(i).getNumbers()%>" id="number<%=i%>" onchange="changePrice(<%=i%>,<%=products.get(i).getPrice()%>,this.value)"/>
                </td>
                <td id="price<%=i%>"><%=products.get(i).getPrices()%></td>
                <td>
                    <button class="btn btn-danger" type="button" onclick="deleteone(<%=i%>,confirm('是否确认删除'));">
                        <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                    </button>
                </td>
              </tr>
            <%
                    allprice=allprice+products.get(i).getPrices();
                }%>
            <tr>
                <td colspan="6" align="right">
                    <button class="btn btn-warning  margin-right-15" type="button" onclick="deleteAll(confirm('是否确认清理购物车'))"> 清空购物车</button>
                    <button class="btn btn-warning margin-right-15" type="button" onclick="location.href='${pageContext.request.contextPath}/front/product/search'"> 继续购物</button>
                    <a onclick="submits()">
                        <button class="btn btn-warning " type="button"> 结算</button>
                    </a>
                </td>
            </tr>
            <tr>
                <td colspan="6" align="right" class="foot-msg">
                    总计： <b><span id="allMoney"><%=allprice%></span> </b>元
                </td>
            </tr>
        </table>
    </div>
    <!-- content end-->
    <!-- footers start -->
    <div class="footers">
        版权所有：Web2019_Group5
    </div>
    <!-- footers end -->
</body>

</html>