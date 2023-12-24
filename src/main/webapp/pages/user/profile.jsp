<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty sessionScope.language ? sessionScope.language : 'en'}"
       scope="session"/>

<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="locale"/>

<html lang="${language}">
<head>
    <meta charset="UTF-8"/>
    <title>Order book</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/profile.css"/>
    <link rel="icon" href="${pageContext.request.contextPath}/static/img/icon/icon.ico">
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<div class="container">
    <div class="main-content">
        <div class="profile-header"><fmt:message key="header.common.profile"/></div>
        <div>

            <label class="profile-label"><fmt:message key="common.profile.login"/></label>
            <div class="user-data">${requestScope.user.username}</div>

            <label class="profile-label"><fmt:message key="common.profile.role"/></label>
            <div class="user-data">${requestScope.user.role}</div>

            <label class="profile-label"><fmt:message key="common.profile.email"/></label>
            <div class="user-data">${requestScope.user.email}</div>

            <label class="profile-label"><fmt:message key="common.profile.phone"/></label>
            <div class="user-data">${requestScope.user.phoneNumber}</div>


            <div class="elem-group inlined"><label class="profile-label"><fmt:message
                    key="common.profile.first.name"/></label>
                <div class="user-data">${requestScope.user.firstName}</div>
            </div>
            <div class="elem-group inlined"><label class="profile-label"><fmt:message
                    key="common.profile.second.name"/></label>
                <div class="user-data">${requestScope.user.lastName}</div>
            </div>

        </div>

    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
</body>
</html>
