<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>个人中心</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script>
        function addTell() {
            $.post(
                '${pageContext.request.contextPath}/front/tell/add',
                {'info':$('#write').val()},
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
                    <font color="#7fff00"><h3>发布帖子</h3></font>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <form class="form-horizontal">
            <div class="form-group">
                <label for="write" class="col-md-2  col-sm-2 control-label"></label>
                <div class="col-md-8 col-sm-10">
                    <textarea rows="4" class="form-control" id="write" placeholder="写帖子" name="myWrite" >
                    </textarea>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="button" class="btn btn-warning" onclick="addTell()">确认发布</button>
                </div>
            </div>
        </form>
        <div class="row">
            <div class="col-xs-12">
                <div class="page-header" style="margin-bottom: 0px;">
                    <font color="#8a2be2"><h3>历史帖子</h3></font>
                </div>
            </div>
            <c:forEach items="${tells.list}" var="tells">
                <div style="background: #99D3F5"><font size="4">${tells.createDate}&nbsp;&nbsp;${tells.customerName}:&nbsp;&nbsp;${tells.info}</font> </div>
            </c:forEach>
        </div>
    </div>
    <!-- content end-->

    <!-- footers start -->
    <div class="footers">
        版权所有：Web2019_Group5
    </div>
    <!-- footers end -->
</body>

</html>