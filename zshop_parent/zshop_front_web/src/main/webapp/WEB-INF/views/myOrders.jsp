<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>我的订单</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script>
        function deleteOrder(orderId) {
            $.post(
                '${pageContext.request.contextPath}/front/Orders/deleteOrder',
                {'orderId':orderId},
                function(result) {
                    if (result.status==1)
                        location.href='${pageContext.request.contextPath}/front/Orders/findAll?page=2';
                }
            )
        }
        function addTellshow(name,number) {
            var show="我在本网站购买了"+number+"个"+name;
            $.post(
                '${pageContext.request.contextPath}/front/tell/add',
                {'info':show},
                function (result) {
                    if (result.status==1)
                        location.href='${pageContext.request.contextPath}/front/tell/findAll?page=4';
                    else
                        alert(result.message);
                }
            )
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
                    <h3>我的订单</h3>
                </div>
            </div>
        </div>
        <table class="table table-hover   orderDetail">
            <c:forEach items="${myOrders.list}" var="myorder">
            <tr>
                <td colspan="5">
                    <span>订单编号：<a href="">${myorder.no}</a></span>
                    <span>成交时间：${myorder.createDate}</span>
                </td>
            </tr>
            <tr>
                <td><img src="http://${pageContext.request.serverName}:9001${myorder.image}" alt=""></td>
                <td class="order-content">
                    <p>
                        ${myorder.name}
                    </p>
                    <p>介绍：${myorder.info}</p>
                    <p>尺码：s</p>
                </td>
                <td>
                    ￥${myorder.price}
                </td>
                <td>
                    ×${myorder.numbers}
                </td>
                <td class="text-color">
                    ￥${myorder.prices}
                </td>
            </tr>
            <tr>
                <td colspan="5">
                    <span ></span>
                    <span class="pull-right">
                        <button type="button" class="btn btn-warning" onclick="addTellshow('${myorder.name}',${myorder.numbers})">炫耀一下</button>
                        <button class="btn btn-danger" onclick="deleteOrder(${myorder.id})">删除订单</button>
                    </span>
                    <span class="">总计:<span class="text-color">￥${myorder.prices}</span></span>
                </td>
            </tr>
            </c:forEach>
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