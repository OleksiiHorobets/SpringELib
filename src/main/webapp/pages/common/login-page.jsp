<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<sec:authorize access="isAuthenticated()">
    <% response.sendRedirect("/home"); %>
</sec:authorize>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty sessionScope.language ? sessionScope.language : 'en'}"
       scope="session"/>

<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="locale"/>

<html lang="${language}">
<head>
    <meta charset="UTF-8"/>
    <title>Library login</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/login.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/login.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/config.js"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/static/img/icon/icon.ico">
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<div class="login-container">
    <div class="container">
        <form class="form" id="login" method="POST" action="/login">
            <sec:csrfInput/>
            <h1 class="form__title"><fmt:message key="loginForm.login"/></h1>
            <div class="form__message form__message--success">
                <c:if test="${not empty requestScope.regMsg}">
                    <fmt:message key="registrationForm.msg.success"/>
                </c:if>
            </div>
            <div class="form__message form__message--error" id="login-error-msg">
                <c:if test="${param.invalidAuth}">
                    <fmt:message key="loginForm.msg.loginError"/>
                </c:if>
                <c:if test="${param.isBlocked}">
                    <fmt:message key="loginForm.msg.userIsBlocked"/>
                </c:if>
            </div>
            <div class="form__input-group">
                <input id="loginUsername" name="username" type="text" class="form__input" autofocus
                       placeholder="<fmt:message key="commonForm.username"/>" value="${sessionScope.username}">
                <div class="form__input-error-message"></div>
            </div>
            <div class="form__input-group">
                <input id="loginPassword" name="password" type="password" class="form__input" autofocus
                       placeholder="<fmt:message key="commonForm.password"/>">
                <div class="form__input-error-message"></div>
            </div>
            <button class="form__button" type="submit"><fmt:message key="loginForm.btn.continue"/></button>
            <p class="form__text">
                <a class="form__link" href=".." id="linkCreateAccount"><fmt:message
                        key="loginForm.btn.createAccount"/></a>
            </p>
        </form>
        <form class="form form--hidden" id="createAccount" action="/auth/register" method="post">
            <sec:csrfInput/>
            <h1 class="form__title">
                <fmt:message key="registrationForm.registration"/>
            </h1>
            <div class="form__message form__message--error"></div>
            <div class="form__input-group">
                <input type="text" id="signupUsername" name="username" class="form__input" required autofocus
                       placeholder="<fmt:message key="commonForm.username"/>" value="${sessionScope.regUser.username}">
                <div class="form__input-error-message">
                    <c:if test="${not empty requestScope.loginAlreadyExists}">
                        <fmt:message key="registrationForm.login_already_exists"/>
                    </c:if>

                </div>
            </div>
            <div class="form__input-group">
                <input type="text" id="signupEmail" class="form__input" name="email" required autofocus
                       placeholder="<fmt:message key="registrationForm.email"/>" value="${sessionScope.regUser.email}">
                <div class="form__input-error-message">
                    <c:if test="${not empty requestScope.emailAlreadyExists}">
                        <fmt:message key="registrationForm.email_already_exists"/>
                    </c:if>
                </div>
            </div>
            <div class="form__input-group">
                <input type="password" id="signupPassword" class="form__input" name="password" required autofocus
                       placeholder="<fmt:message key="commonForm.password"/>">
                <div class="form__input-error-message">

                </div>
            </div>
            <div class="form__input-group">
                <input type="password" id="signupConfirmPassword" class="form__input" name="regConfirmPassword" required
                       autofocus placeholder="<fmt:message key="registrationForm.confirmPassword"/>">
                <div class="form__input-error-message"></div>
            </div>
            <div class="form__input-group">
                <input type="text" id="signupPhone" class="form__input" name="phoneNumber" autofocus
                       placeholder="<fmt:message key="registrationForm.phone"/>">
                <div class="form__input-error-message">
                    <c:if test="${not empty sessionScope.phoneAlreadyExists}">
                        <fmt:message key="registrationForm.phone_already_exists"/>
                    </c:if>
                </div>
            </div>
            <div class="form__input-group">
                <input type="text" id="firstName" class="form__input" name="firstName" required autofocus
                       placeholder="<fmt:message key="registrationForm.firstName"/>"
                       value="${sessionScope.regUser.firstName}">
                <div class="form__input-error-message"></div>
            </div>
            <div class="form__input-group">
                <input type="text" id="secondName" class="form__input" name="lastName" required autofocus
                       placeholder="<fmt:message key="registrationForm.secondName"/>"
                       value="${sessionScope.regUser.lastName}">
                <div class="form__input-error-message"></div>
            </div>
            <button class="form__button" type="submit"><fmt:message key="registrationForm.btn.create"/></button>
            <p class="form__text">
                <a class="form__link" href=".." id="linkLogin"><fmt:message key="registrationForm.btn.signIn"/></a>
            </p>
        </form>
        <div id="registration_flag" hidden>${requestScope.regForm}</div>
    </div>
</div>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>