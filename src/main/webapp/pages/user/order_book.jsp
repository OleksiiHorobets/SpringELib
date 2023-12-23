<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty sessionScope.language ? sessionScope.language : 'en'}"
       scope="session"/>

<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="locale"/>

<html lang="${language}">
<head>
    <meta charset="UTF-8"/>
    <title>Order book</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/order_book.css"/>
    <link rel="icon" href="${pageContext.request.contextPath}/static/img/icon/icon.ico">
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<sec:csrfMetaTags/>
<div class="container">
    <div class="main-content">

        <div class="order-header"><fmt:message key="user.books.label.title"/></div>
        <div>
            <label class="order-book-label"><fmt:message key="admin.books.edit.form.label.book.title"/></label>
            <div class="book-data">- ${requestScope.book.title}</div>

            <label class="order-book-label"><fmt:message key="user.books.label.author"/></label>
            <div class="book-data">- ${requestScope.book.author.firstName} ${requestScope.book.author.lastName}</div>

            <label class="order-book-label"><fmt:message key="user.books.label.genre"/></label>
            <div class="book-data">- ${requestScope.book.genre.title}</div>


            <label class="order-book-label"><fmt:message key="user.books.label.publisher"/></label>
            <div class="book-data">- ${requestScope.book.publisher.title}</div>

            <label class="order-book-label"><fmt:message key="user.books.label.page.number"/></label>
            <div class="book-data">- ${requestScope.book.pages}</div>


            <label class="order-book-label"><fmt:message key="user.books.label.publication.date"/></label>
            <div class="book-data">- ${requestScope.book.publicationDate}</div>

            <form action="/orders" method="post">
                <input name="bookId" type="hidden" value="${requestScope.book.bookId}">
                <sec:csrfInput/>
                <select id="subscription-type-select" name="orderType">
                    <%--                    TODO: add localization--%>
                    <option value="READING_ROOM">To the reading room</option>
                    <option value="ON_SUBSCRIPTION">On subscription (30 days)</option>
                </select>
                <button class="submit-order-button" type="submit"
                        style="margin-top:20px; margin-left: 43%; padding: 10px 20px"><fmt:message
                        key="admin.books.edit.form.label.submit.btn"/></button>
            </form>

        </div>

    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
</body>
</html>
