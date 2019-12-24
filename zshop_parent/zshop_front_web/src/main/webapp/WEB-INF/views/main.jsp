<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>在线购物商城</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/iconfont/iconfont.css">
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/zshop.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script>
        //分页设置
        $(function () {
            $('#pagination').bootstrapPaginator({
                bootstrapMajorVersion:3,
                currentPage:${pageInfo.pageNum},
                totalPages:${pageInfo.pages},
                pageUrl:function (type,page,current) {
                    return '${pageContext.request.contextPath}/front/product/search?pageNum='+page;
                },
                itemTexts:function (type,page,current) {
                    switch (type) {
                        case "first":return "首页";
                        case "prev":return "上一页";
                        case "next":return "下一页";
                        case "last":return "末页";
                        case "page":return page;
                    }
                }
            });
        });
        //添加到购物车
        function addOrder(id) {
            $.post(
                '${pageContext.request.contextPath}/front/sessions/addSession',
                {'id':id},
                function (result) {
                    alert(result.message);
                }
            );
        }
    </script>
</head>

<body>
    <div id="wrapper" class="text-center">
        <!-- navbar start -->
        <jsp:include page="top.jsp"/>
        <!-- navbar end -->
        <!-- content start -->
        <div class="container">
            <div class="row">
                <div class="col-xs-12">
                    <div class="page-header" style="margin-bottom: 0px;">
                        <h3>商品列表</h3>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-xs-12">
                    <form class="form-inline hot-search" action="${pageContext.request.contextPath}/front/product/search" method="post">
                        <div class="form-group">
                            <label class="control-label">商品：</label>
                            <input type="text" class="form-control" placeholder="商品名称" name="name" value="${productParam.name}">
                        </div>
                        &nbsp;
                        <div class="form-group">
                            <label class="control-label">价格：</label>
                            <input type="text" class="form-control" placeholder="最低价格" name="minPrice" value="${productParam.minPrice}"> --
                            <input type="text" class="form-control" placeholder="最高价格" name="maxPrice" value="${productParam.maxPrice}">
                        </div>
                        &nbsp;
                        <div class="form-group">
                            <label class="control-label">种类：</label>
                            <select class="form-control input-sm" name="productTypeId" >
                                <option value="-1" selected="selected">查询全部</option>
                                <c:forEach items="${productTypes}" var="productType">
                                    <option value="${productType.id}" <c:if test="${productType.id==productParam.productTypeId}">selected</c:if>>${productType.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        &nbsp;
                        <div class="form-group">
                            <button type="submit" class="btn btn-warning">
                                <i class="glyphicon glyphicon-search"></i> 查询
                            </button>
                        </div>    
                    </form>
                </div>
            </div>
        </div>
        <div class="content-back">
            <div class="container" id="a">
                <div class="row">
                    <c:forEach items="${pageInfo.list}" var="product">
                        <div class="col-xs-3  hot-item">
                            <div class="panel clear-panel">
                                <div class="panel-body">
                                    <div class="art-back clear-back">
                                        <div class="add-padding-bottom">
                                            <img src="http://${pageContext.request.serverName}:9001${product.image}" class="shopImg">
                                        </div>
                                        <h4><a href="">${product.name}</a></h4>
                                        <div class="user clearfix pull-right">
                                            ￥${product.price}
                                        </div>
                                        <div class="desc">${product.info}</div>
                                        <div class="attention pull-right" onclick="addOrder(${product.id})">
                                            加入购物车 <i class="icon iconfont icon-gouwuche"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <!-- content end-->
        <ul id="pagination"></ul>
        <!-- footers start -->
        <div class="footers">
            版权所有：Web2019_Group5
        </div>
        <!-- footers end -->
    </div>
</body>

</html>