<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>backend</title>
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/index.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/userSetting.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/zshop.css">
    <script>
        $(function () {
            $('#pagination').bootstrapPaginator({
                bootstrapMajorVersion:3,
                currentPage:${pageInfo.pageNum},
                totalPages:${pageInfo.pages},
                onPageClicked:function(even,originalEven,type,page){
                    $('#pageNum').val(page);
                    $('#frmSearch').submit();
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
        //修改客户状态
        function modifyStatus(id,btn) {
            $.get(
                '${pageContext.request.contextPath}/backend/customer/modifyStatus',
                {'id':id},
                function (result) {
                    if (result.status==1){
                        //局部刷新
                        let $td=$(btn).parent().prev();
                        if ($td.text().trim()=='有效') {
                            $td.text('无效');
                            $(btn).val("启用").removeClass("btn-danger").addClass("btn-success");
                        }
                        else {
                            $td.text('有效');
                            $(btn).val("禁用").removeClass("btn-success").addClass("btn-danger")
                        }
                    }
                    else
                        alert(result.message);
                }
            );
        }
    </script>
</head>

<body>
<div class="panel panel-default" id="userInfo" id="homeSet">
    <div class="panel-heading">
        <h3 class="panel-title">客户管理</h3>
    </div>
    <div class="panel-body">
        <div class="showusersearch">
            <form class="form-inline"action="${pageContext.request.contextPath}/backend/customer/findByParams" method="post" id="frmSearch">
                <input type="hidden" name="pageNum" value="${pageInfo.pageNum}" id="pageNum">
                <div class="form-group">
                    <label for="customer_name">姓名:</label>
                    <input type="text" class="form-control"id="customer_name" name="name" placeholder="请输入姓名" size="15px" value="${customerParam.name}">
                </div>
                <div class="form-group">
                    <label for="customer_loginName">帐号:</label>
                    <input type="text" class="form-control" id="customer_loginName" name="loginName" placeholder="请输入帐号" size="15px" value="${customerParam.loginName}">
                </div>
                <div class="form-group">
                    <label for="customer_phone">电话:</label>
                    <input type="text" class="form-control" id="customer_phone" name="phone" placeholder="请输入电话" size="15px"value="${customerParam.phone}">
                </div>
                <div class="form-group">
                    <label for="customer_address">地址:</label>
                    <input type="text" class="form-control" id="customer_address" name="address" placeholder="请输入地址"value="${customerParam.address}">
                </div>
                <div class="form-group">
                    <label for="customer_isValid">状态:</label>
                    <select class="form-control" id="customer_isValid" name="isValid">
                        <option value="-1">全部</option>
                        <option value="1"<c:if test="${customerParam.isValid==1}">selected</c:if>>>---有效---</option>
                        <option value="0"<c:if test="${customerParam.isValid==0}">selected</c:if>>>---无效---</option>
                    </select>
                </div>
                <input type="submit" value="查询" class="btn btn-primary" id="doSearch">
            </form>
        </div>

        <div class="show-list" style="position: relative;top: 30px;">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">序号</th>
                    <th class="text-center">姓名</th>
                    <th class="text-center">帐号</th>
                    <th class="text-center">电话</th>
                    <th class="text-center">地址</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                  <c:forEach items="${pageInfo.list}" var="customer">
                <tr>
                    <td>${customer.id}</td>
                    <td>${customer.name}</td>
                    <td>${customer.loginName}</td>
                    <td>${customer.phone}</td>
                    <td>${customer.address}</td>
                    <td>
                        <c:if test="${customer.isValid==1}">有效</c:if>
                        <c:if test="${customer.isValid==0}">无效</c:if>
                    </td>
                    <td class="text-center">
                        <c:if test="${customer.isValid==1}">
                            <input type="button" class="btn btn-danger btn-sm doMangerDisable" value="禁用" onclick="modifyStatus(${customer.id},this)">
                        </c:if>
                        <c:if test="${customer.isValid==0}">
                            <input type="button" class="btn btn-success btn-sm doMangerDisable" value="启用" onclick="modifyStatus(${customer.id},this)">
                        </c:if>
                    </td>
                </tr>
                  </c:forEach>
                </tbody>
            </table>
            <ul id="pagination"></ul>
        </div>
    </div>
</div>
</body>

</html>