<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty sessionScope.language ? sessionScope.language : 'en'}"
       scope="session"/>

<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="locale"/>

<!DOCTYPE>
<html lang="${language}">
<head>
    <meta charset="UTF-8"/>
    <title>Users</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/users.css"/>
    <script src="https://kit.fontawesome.com/e83e8567ce.js" crossorigin="anonymous"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/static/img/icon/icon.ico">
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<sec:csrfMetaTags/>
<div class="container">
    <div class="main-content">
        <div class="top-row">
            <p class="users-list-title"><fmt:message key="admin.user.users.title"/></p>
        </div>
        <div class="users_list_container">
            <table class="users_table" aria-label="users-table">
                <tr>
                    <th><fmt:message key="common.label.counter"/></th>

                    <th><fmt:message key="admin.users.user.id"/></th>

                    <th><fmt:message key="admin.users.user.login"/></th>

                    <th><fmt:message key="admin.users.user.name"/></th>
                    <th><fmt:message key="admin.users.user.email"/></th>
                    <th><fmt:message key="admin.users.user.phone"/></th>


                    <th><fmt:message key="admin.users.user.role"/></th>
                    <th style="min-width: 150px;"><fmt:message key="admin.users.user.status"/></th>
<%--                    <th style="min-width: 230px;"><fmt:message key="admin.users.user.change.role"/></th>--%>

                </tr>
                <c:forEach var="users" items="${requestScope.usersList.content}" varStatus="loop">
                    <tr <c:if test="${users.isBanned eq true}">style="background: #d72d2d;"</c:if>>

                        <td> ${loop.count + (requestScope.usersList.pageable.pageNumber) * requestScope.usersList.size} </td>
                        <td> ${users.id} </td>


                        <td> ${users.username}</td>

                        <td> ${users.firstName} ${users.lastName}</td>
                        <td> ${users.email} </td>
                        <td> ${users.phoneNumber} </td>

                            <%--                        <c:if test="${sessionScope.user.role eq 'LIBRARIAN'}">--%>
                            <%--                            <c:choose>--%>
                            <%--                                <c:when test="${users.isBanned eq true}">--%>
                            <%--                                    <td><fmt:message key="admin.user.msg.banned"/></td>--%>
                            <%--                                </c:when>--%>
                            <%--                                <c:otherwise>--%>
                            <%--                                    <td><fmt:message key="admin.user.msg.not.banned"/></td>--%>
                            <%--                                </c:otherwise>--%>
                            <%--                            </c:choose>--%>

                            <%--                        </c:if>--%>


                        <td> ${users.role} </td>

                        <c:choose>
                            <c:when test="${users.role ne 'ROLE_ADMIN'}">
                                <c:choose>
                                    <c:when test="${users.isBanned eq true}">
                                        <td class="ban-user">
                                            <style>
                                                .ban-user:hover a p.label:after {
                                                    content: '<fmt:message key="admin.users.action.unban"/>';
                                                }

                                                .ban-user:hover a p.label span {
                                                    display: none;
                                                }

                                            </style>
                                            <div class="removed-order-div">
                                                <a class="remove-link"
                                                   href="#" onclick="changeUserStatus(${users.id}, false)">
                                                    <p class="label"><span class="align"><fmt:message
                                                            key="admin.user.msg.banned"/></span></p>
                                                </a>
                                            </div>
                                        </td>
                                    </c:when>
                                    <c:otherwise>
                                        <td class="unban-user">
                                            <style>
                                                .unban-user:hover a p.label:after {
                                                    content: '<fmt:message key="admin.users.action.ban"/>';
                                                }

                                                .unban-user:hover a p.label span {
                                                    display: none;
                                                }
                                            </style>
                                            <div class="removed-book-div">
                                                <a class="remove-link"
                                                   href="#" onclick="changeUserStatus(${users.id}, true)">
                                                    <p class="label"><span class="align">
                                                            <fmt:message key="admin.user.msg.not.banned"/></span></p>
                                                </a>
                                            </div>
                                        </td>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${users.isBanned eq true}">
                                        <td><fmt:message key="admin.user.msg.banned"/></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td><fmt:message key="admin.user.msg.not.banned"/></td>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>


<%--                        <c:choose>--%>
<%--                            <c:when test="${users.role ne 'ROLE_ADMIN' and !users.isBanned}">--%>
<%--                                <c:choose>--%>
<%--                                    <c:when test="${users.role eq 'ROLE_USER'}">--%>
<%--                                        <td class="change-role-to-user">--%>
<%--                                            <style>--%>
<%--                                                .change-role-to-user:hover a p.label:after {--%>
<%--                                                    content: '<fmt:message key="admin.users.action.lib"/>';--%>
<%--                                                }--%>

<%--                                                .change-role-to-user:hover a p.label span {--%>
<%--                                                    display: none;--%>
<%--                                                }--%>
<%--                                            </style>--%>
<%--                                            <div class="removed-book-div">--%>
<%--                                                <a class="remove-link"--%>
<%--                                                   href="controller?command=change-user-role&role=librarian&user_id=${users.id}">--%>
<%--                                                    <p class="label"><span class="align"><fmt:message--%>
<%--                                                            key="admin.users.msg.user"/></span></p>--%>
<%--                                                </a>--%>
<%--                                            </div>--%>
<%--                                        </td>--%>
<%--                                    </c:when>--%>
<%--                                    <c:otherwise>--%>
<%--                                        <td class="change-role-to-lib">--%>
<%--                                            <style>--%>
<%--                                                .change-role-to-lib:hover a p.label:after {--%>
<%--                                                    content: '<fmt:message key="admin.users.action.user"/>';--%>
<%--                                                }--%>

<%--                                                .change-role-to-lib:hover a p.label span {--%>
<%--                                                    display: none;--%>
<%--                                                }--%>
<%--                                            </style>--%>
<%--                                            <div class="removed-book-div">--%>
<%--                                                <a class="remove-link"--%>
<%--                                                   href="controller?command=change-user-role&role=user&user_id=${users.id}">--%>
<%--                                                    <p class="label"><span class="align"--%>
<%--                                                                           style="text-align: center;">--%>
<%--                                                            <fmt:message key="admin.users.msg.librarian"/></span></p>--%>
<%--                                                </a>--%>
<%--                                            </div>--%>
<%--                                        </td>--%>
<%--                                    </c:otherwise>--%>
<%--                                </c:choose>--%>
<%--                            </c:when>--%>
<%--                            <c:otherwise>--%>
<%--                                <c:choose>--%>
<%--                                    <c:when test="${users.role ne 'ROLE_ADMIN'}">--%>
<%--                                        <td><fmt:message key="admin.user.msg.unban.first"/></td>--%>
<%--                                    </c:when>--%>
<%--                                    <c:otherwise>--%>
<%--                                        <td><fmt:message key="admin.user.msg.unsupported"/></td>--%>
<%--                                    </c:otherwise>--%>
<%--                                </c:choose>--%>
<%--                            </c:otherwise>--%>
<%--                        </c:choose>--%>
                    </tr>
                </c:forEach>
            </table>


        </div>
        <c:if test="${requestScope.usersList.totalPages > 0}">
            <c:set var="currPage" scope="request"
                   value="${requestScope.usersList.pageable.pageNumber}"/>
            <div class="pages_container">
                    <%--For displaying Previous link except for the 1st page --%>
                <c:if test="${currPage != 0}">
                    <a href="/users?page=${currPage - 1}">&laquo;</a>
                </c:if>
                    <%--For displaying Page numbers.
                        The when condition does not display a link for the current page--%>
                <c:forEach begin="0" end="${requestScope.usersList.totalPages - 1 }" var="i">
                    <c:choose>
                        <c:when test="${currPage eq i}">
                            <a href="/users?page=${i}"
                               class="active"> ${i + 1}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/users?page=${i}">${i + 1}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                    <%--For displaying Next link --%>
                <c:if test="${currPage + 1 lt requestScope.usersList.totalPages}">
                    <a href="/users?page=${currPage + 1}">&raquo;</a>
                </c:if>

            </div>

        </c:if>

    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
</body>
<script>
    function changeUserStatus(userId, isBanned) {
        let csrfToken = $("meta[name='_csrf']").attr("content");
        let csrfHeader = $("meta[name='_csrf_header']").attr("content");


        $.ajax({
            type: "PATCH",
            url: "/api/v1/users/" + userId + "?isBanned=" + isBanned,
            success: function (response) {
                location.reload();
                console.log("Form submitted successfully:", response);
            },
            error: function (error) {
                window.location.href = "/error/400";
                console.error("Error submitting form:", error);
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            }
        });
    }
</script>
</html>
