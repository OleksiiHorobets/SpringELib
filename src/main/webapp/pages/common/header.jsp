<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<c:set var="language"
       value="${not empty param.language ? param.language : not empty sessionScope.language ? sessionScope.language : 'en'}"
       scope="session"/>

<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="locale"/>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/header.css"/>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300&display=swap" rel="stylesheet">
<script
        src="https://kit.fontawesome.com/d117408745.js"
        crossorigin="anonymous"
></script>

<div class="header">
    <div class="left-header">

        <a class="active" href="${pageContext.request.contextPath}/home"><fmt:message
                key="header.common.home"/></a>

        <a href="${pageContext.request.contextPath}/books"><fmt:message key="header.common.books"/></a>
        <%--        <h1><sec:authentication property="principal.authorities" /></h1>--%>
        <sec:authorize access="hasRole('USER')">
            <%-- Menu bar for user only--%>
            <a href="${pageContext.request.contextPath}/controller?command=display-my-orders"><fmt:message
                    key="header.user.order"/></a>
            <a href="${pageContext.request.contextPath}/controller?command=display-my-requested-orders"><fmt:message
                    key="header.user.requested.orders"/></a>
        </sec:authorize>
        <sec:authorize access="hasRole('ADMIN')">
            <a href="${pageContext.request.contextPath}/controller?command=display-users"><fmt:message
                    key="header.admin.users"/></a>
            <a href="${pageContext.request.contextPath}/controller?command=display-users-orders"><fmt:message
                    key="header.admin.orders"/></a>
            <a href="${pageContext.request.contextPath}/controller?command=display-users-requested-orders"><fmt:message
                    key="header.admin.requested.orders"/></a>
        </sec:authorize>

        <%--        </c:choose><c:choose>--%>
        <%--            &lt;%&ndash; Menu bar for user only&ndash;%&gt;--%>
        <%--            <c:when test="${sessionScope.user.role eq 'USER'}">--%>
        <%--                <a href="${pageContext.request.contextPath}/controller?command=display-my-orders"><fmt:message--%>
        <%--                        key="header.user.order"/></a>--%>
        <%--                <a href="${pageContext.request.contextPath}/controller?command=display-my-requested-orders"><fmt:message--%>
        <%--                        key="header.user.requested.orders"/></a>--%>
        <%--            </c:when>--%>
        <%--            &lt;%&ndash; Menu bar for Admin or Librarian only&ndash;%&gt;--%>
        <%--            <c:when test="${sessionScope.user.role eq 'LIBRARIAN'}">--%>
        <%--                <a href="${pageContext.request.contextPath}/controller?command=display-readers"><fmt:message--%>
        <%--                        key="header.admin.readers"/></a>--%>
        <%--                <a href="${pageContext.request.contextPath}/controller?command=display-users-orders"><fmt:message--%>
        <%--                        key="header.admin.orders"/></a>--%>
        <%--                <a href="${pageContext.request.contextPath}/controller?command=display-users-requested-orders"><fmt:message--%>
        <%--                        key="header.admin.requested.orders"/></a>--%>
        <%--            </c:when>--%>
        <%--            <c:when test="${sessionScope.user.role eq 'ADMIN'}">--%>
        <%--                <a href="${pageContext.request.contextPath}/controller?command=display-users"><fmt:message--%>
        <%--                        key="header.admin.users"/></a>--%>
        <%--                <a href="${pageContext.request.contextPath}/controller?command=display-users-orders"><fmt:message--%>
        <%--                        key="header.admin.orders"/></a>--%>
        <%--                <a href="${pageContext.request.contextPath}/controller?command=display-users-requested-orders"><fmt:message--%>
        <%--                        key="header.admin.requested.orders"/></a>--%>
        <%--            </c:when>--%>
        <%--        </c:choose>--%>
    </div>

    <div class="right-header">
        <div class="search-container">
            <%--            <form action="${pageContext.request.contextPath}/controller">--%>
            <div id="search-by-div" hidden="hidden">${requestScope.searchBy}</div>
            <form action="/books/search">
                <sec:csrfInput/>
                <select name="searchBy"
                        style="font-size: 17px; background: #e9e9e9; font-family: 'Open Sans', sans-serif;">
                    <option class="option-div" value="by_title"><fmt:message
                            key="header.common.search.by.title"/></option>
                    <option class="option-div" value="by_author"><fmt:message
                            key="header.common.search.by.author"/></option>
                </select>
                <label>
                    <input type="text" placeholder="<fmt:message key="header.common.search"/>"
                           value="${requestScope.searchContent}" name="searchContent"/>
                </label>
                <button type="submit"><i class="fa fa-search"></i></button>
            </form>
        </div>


        <div class="languages">
            <sec:csrfMetaTags/>
            <a href="#" onclick="changeLanguage('ua')">
                <fmt:message key="header.language.ua"/>
            </a>
            <a href="#" onclick="changeLanguage('en')">
                <fmt:message key="header.language.en"/>
            </a>

        </div>


        <sec:authorize access="isAuthenticated()">
            <a href="${pageContext.request.contextPath}/controller?command=my-profile"><fmt:message
                    key="header.common.profile"/></a>
            <a href="#" onclick="logout()"><fmt:message
                    key="header.common.logout"/></a>
        </sec:authorize>
        <sec:authorize access="isAnonymous()">
            <a href="${pageContext.request.contextPath}/auth/login?from=header"><fmt:message
                    key="header.common.login"/></a>
        </sec:authorize>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    function changeLanguage(language) {
        let csrfToken = $("meta[name='_csrf']").attr("content");
        let csrfHeader = $("meta[name='_csrf_header']").attr("content");

        $.ajax({
            type: "POST",
            url: "/language",
            data: {language: language},
            success: function () {
                location.reload();
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            }
        });
    }

    function logout() {
        let csrfToken = $("meta[name='_csrf']").attr("content");
        let csrfHeader = $("meta[name='_csrf_header']").attr("content");

        $.ajax({
            type: "POST",
            url: "/logout",
            success: function () {
                location.reload();
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            }
        });
    }
</script>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        let searchByDiv = document.getElementById('search-by-div');
        let searchByValue = searchByDiv.textContent.trim();

        let selectElement = document.querySelector('select[name="searchBy"]');

        let options = selectElement.options;
        for (let i = 0; i < options.length; i++) {
            if (options[i].value === searchByValue) {
                options[i].selected = true;
                break;
            }
        }
    });
</script>