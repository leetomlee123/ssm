<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>搜索结果</title>
    <script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"/>
    <script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>

<body>
<div class="container" style="text-align: center;margin-top: 50px">
    <%--add modal--%>
    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">

                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/users" method="post" id="addForm">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">姓名</span>
                            </div>
                            <input name="name" type="text" class="form-control">
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">生日</span>
                            </div>
                            <input name="birthday" type="date"
                                   class="form-control">
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">余额</span>
                            </div>
                            <input onKeyPress="if (event.keyCode!=46 && event.keyCode!=45 && event.keyCode<48 || event.keyCode>57) event.returnValue=false"
                                   name="balance" class="form-control">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="add">提交</button>
                </div>
            </div>
        </div>
    </div>

    <%--edit modal--%>
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="modal-header">
                        <h4 class="modal-title">修改用户</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="form-group">
                        <input hidden id="id" type="text">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">姓名</span>
                            </div>
                            <input name="name" type="text" class="form-control" id="name">
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">生日</span>
                            </div>
                            <input
                                    name="birthday"
                                    type="date"
                                    class="form-control" id="birthday">
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">余额</span>
                            </div>
                            <input onKeyPress="if (event.keyCode!=46 && event.keyCode!=45 && event.keyCode<48 || event.keyCode>57) event.returnValue=false"
                                   name="balance" class="form-control" id="balance">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="close">关闭</button>
                        <button type="button" class="btn btn-primary" id="edit">提交</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-4" style="margin-bottom: 10px">
            <div class="input-group">
                <button href="/" type="button" class="btn btn-default " id="search" style="margin-left: 5px">
                    返回
                </button>
            </div>
        </div>

    </div>
    <table class="table" style="margin: auto">
        <tr>
            <td>姓名</td>
            <td>年龄</td>
            <td>生日</td>
            <td>余额</td>
            <td>删除</td>
            <td>编辑</td>
        </tr>
        <c:forEach items="${users}" var="user">
            <tr>
                <td>${user.name}</td>
                <td>${user.age}</td>
                <td><fmt:formatDate value="${user.birthday}" pattern="yyyy年MM月dd日"/></td>
                <td><fmt:formatNumber value="${user.balance}" pattern="#0.0000"/></td>
                <td>
                    <button value="${user.id}" type="button" class="btn btn-danger del">删除</button>
                </td>
                <td>
                    <button value="${user.id}" type="button" class="btn btn-info edit" data-toggle="modal"
                            data-target="#editModal">修改
                    </button>
                </td>
            </tr>
        </c:forEach>
    </table>


</body>
<script>
    $("#add").click(function () {
        $("#addForm").submit();
    })
    $(".edit").click(function () {
        $.ajax({
            type: "GET",
            url: "/users/" + this.value,
            success: function (data) {
                $("#id").val(data.id);
                $("#name").val(data.name);
                $("#age").val(data.age);
                $("#birthday").val(data.birthday);
                $("#balance").val(data.balance);
            }
        });
    })
    $("#edit").click(function () {
        var jsonstr = {
            "id": $("#id").val(),
            "name": $("#name").val(),
            "age": $("#age").val(),
            "birthday": $("#birthday").val(),
            "balance": $("#balance").val()
        };
        $.ajax({
            type: "PUT",
            url: "/users",
            async: false,
            contentType: "application/json",//设置请求参数类型为json字符串
            data: JSON.stringify(jsonstr),//将json对象转换成json字符串发送
            success: function (data) {
                if ("SUCCESS" == data) {
                    $("#close").click();
                }
            }
        });
        window.location.reload(true)
    })
    $(".del").click(function () {
        $.ajax({
            type: "DELETE",
            url: "/users/" + this.value,
            async: false,
            success: function (data) {
                if ("SUCCESS" == data) {
                }
            }
        });
        window.location.reload(true)
    })
    $("#search").click(function () {
        location.href = "/"
    })

</script>
</html>