<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty sessionScope.language ? sessionScope.language : 'en'}"
       scope="session"/>

<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="locale"/>

<!DOCTYPE>
<html lang="${language}">
<head>
    <title>Forbidden!</title>
    <%--    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/not_authorized.css"/>--%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/index.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/not_authorized.css"/>
    <link rel="icon" href="${pageContext.request.contextPath}/static/img/icon/icon.ico">

</head>
<body>
<div class="container">
    <jsp:include page="../common/header.jsp"/>
    <div class="msg-container">
        <div class="messages">
            <div class="message">FORBIDDEN</div>
            <div class="message2">You are not allowed to visit this page!</div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp"/>
</div>
</body>
</html>
