<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


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

        <a class="active" href="${pageContext.request.contextPath}/controller?command=home"><fmt:message
                key="header.common.home"/></a>

        <a href="${pageContext.request.contextPath}/books"><fmt:message key="header.common.books"/></a>

        <c:choose>
            <%-- Menu bar for user only--%>
            <c:when test="${sessionScope.user.role eq 'USER'}">
                <a href="${pageContext.request.contextPath}/controller?command=display-my-orders"><fmt:message
                        key="header.user.order"/></a>
                <a href="${pageContext.request.contextPath}/controller?command=display-my-requested-orders"><fmt:message
                        key="header.user.requested.orders"/></a>
            </c:when>
            <%-- Menu bar for Admin or Librarian only--%>
            <c:when test="${sessionScope.user.role eq 'LIBRARIAN'}">
                <a href="${pageContext.request.contextPath}/controller?command=display-readers"><fmt:message
                        key="header.admin.readers"/></a>
                <a href="${pageContext.request.contextPath}/controller?command=display-users-orders"><fmt:message
                        key="header.admin.orders"/></a>
                <a href="${pageContext.request.contextPath}/controller?command=display-users-requested-orders"><fmt:message
                        key="header.admin.requested.orders"/></a>
            </c:when>
            <c:when test="${sessionScope.user.role eq 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/controller?command=display-users"><fmt:message
                        key="header.admin.users"/></a>
                <a href="${pageContext.request.contextPath}/controller?command=display-users-orders"><fmt:message
                        key="header.admin.orders"/></a>
                <a href="${pageContext.request.contextPath}/controller?command=display-users-requested-orders"><fmt:message
                        key="header.admin.requested.orders"/></a>
            </c:when>
        </c:choose>
    </div>

    <div class="right-header">
        <div class="search-container">
            <form action="${pageContext.request.contextPath}/controller">
                <input name="command" type="hidden" value="search-book">
                <select name="search_by"
                        style="font-size: 17px; background: #e9e9e9; font-family: 'Open Sans', sans-serif;">
                    <option class="option-div" value="by_title"><fmt:message
                            key="header.common.search.by.title"/></option>
                    <option class="option-div" value="by_author"><fmt:message
                            key="header.common.search.by.author"/></option>
                </select>
                <label>
                    <input type="text" placeholder="<fmt:message key="header.common.search"/>" name="search"/>
                </label>
                <button type="submit"><i class="fa fa-search"></i></button>
            </form>
        </div>


        <div class="languages">


            <a href="#" onclick="changeLanguage('ua')">
                <fmt:message key="header.language.ua"/>
            </a>
            <a href="#" onclick="changeLanguage('en')">
                <fmt:message key="header.language.en"/>
            </a>

        </div>

        <c:choose>
            <c:when test="${sessionScope.user == null}">
                <a href="${pageContext.request.contextPath}/login&from=header"><fmt:message
                        key="header.common.login"/></a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/controller?command=my-profile"><fmt:message
                        key="header.common.profile"/></a>
                <a href="${pageContext.request.contextPath}/controller?command=logout"><fmt:message
                        key="header.common.logout"/></a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    function changeLanguage(language) {
        $.ajax({
            type: "POST",
            url: "/language",
            data: {language: language},
            success: function () {
                location.reload();
            }
        });
    }
</script>
