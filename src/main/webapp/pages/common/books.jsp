<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%--<%@ taglib prefix="custom" uri="/WEB-INF/custom.tld" %>--%>

<c:set var="orderBy" scope="request" value="${requestScope.orderBy}"/>
<c:set var="dir" scope="request" value="${requestScope.dir}"/>
<c:set var="userRole" scope="request" value="${sessionScope.user.role}"/>
<c:set var="searchContent" scope="request" value="${requestScope.searchContent}"/>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty sessionScope.language ? sessionScope.language : 'en'}"
       scope="session"/>

<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="locale"/>

<html lang="${language}">
<head>
    <meta charset="UTF-8"/>
    <title>Books</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/books.css"/>
    <%--    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/index.css"/>--%>
    <script src="https://kit.fontawesome.com/e83e8567ce.js" crossorigin="anonymous"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/static/img/icon/icon.ico">
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="container">
    <div class="main-content">
        <div class="books-top-row">
            <p class="books-list-title"><fmt:message key="books.common.label.books.list"/></p>
            <sec:authorize access="hasRole('ADMIN')">
                <a href="/books/create" class="books-add-new">
                    <fmt:message key="admin.books.edit.form.title.add"/>
                </a>
            </sec:authorize>
        </div>
        <div class="books_list_container">
            <table class="books_table">
                <tr>
                    <th><fmt:message key="common.label.counter"/></th>

                    <c:choose>
                    <c:when test="${orderBy eq 'title'}">
                    <c:choose>
                    <c:when test="${dir eq 'asc'}">
                    <th class="active">

                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=title&dir=desc">
                                    <fmt:message key="books.common.label.book_title"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=title&dir=desc">
                                    <fmt:message key="books.common.label.book_title"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>

                    </th>
                    </c:when>
                    <c:otherwise>
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=title&dir=asc">
                                    <fmt:message key="books.common.label.book_title"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=title&dir=asc">
                                    <fmt:message key="books.common.label.book_title"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:otherwise>
                    </c:choose>
                    </c:when>
                    <c:otherwise>
                    <th>
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=title&dir=asc">
                                    <fmt:message key="books.common.label.book_title"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=title&dir=asc">
                                    <fmt:message key="books.common.label.book_title"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:otherwise>
                    </c:choose>

                    <c:choose>
                    <c:when test="${orderBy eq 'genre'}">
                    <c:choose>
                    <c:when test="${dir eq 'asc'}">


                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=genre&dir=desc">
                                    <fmt:message key="books.common.label.genre"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=genre&dir=desc">
                                    <fmt:message key="books.common.label.genre"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:when>
                    <c:otherwise>
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=genre&dir=asc">
                                    <fmt:message key="books.common.label.genre"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=genre&dir=asc">
                                    <fmt:message key="books.common.label.genre"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:otherwise>
                    </c:choose>
                    </c:when>
                    <c:otherwise>

                    <th>
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=genre&dir=asc">
                                    <fmt:message key="books.common.label.genre"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=genre&dir=asc">
                                    <fmt:message key="books.common.label.genre"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:otherwise>
                    </c:choose>

                    <c:choose>
                    <c:when test="${orderBy eq 'author'}">
                    <c:choose>
                    <c:when test="${dir eq 'asc'}">
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=author&dir=desc">
                                    <fmt:message key="books.common.label.author"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=author&dir=desc">
                                    <fmt:message key="books.common.label.author"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:when>
                    <c:otherwise>
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=author&dir=asc">
                                    <fmt:message key="books.common.label.author"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=author&dir=asc">
                                    <fmt:message key="books.common.label.author"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:otherwise>
                    </c:choose>
                    </c:when>
                    <c:otherwise>
                    <th>
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=author&dir=asc">
                                    <fmt:message key="books.common.label.author"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=author&dir=asc">
                                    <fmt:message key="books.common.label.author"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:otherwise>
                    </c:choose>

                    <c:choose>
                    <c:when test="${orderBy eq 'publisher'}">
                    <c:choose>
                    <c:when test="${dir eq 'asc'}">
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=publisher&dir=desc">
                                    <fmt:message key="books.common.label.publisher"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=publisher&dir=desc">
                                    <fmt:message key="books.common.label.publisher"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:when>
                    <c:otherwise>
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=publisher&dir=asc">
                                    <fmt:message key="books.common.label.publisher"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=publisher&dir=asc">
                                    <fmt:message key="books.common.label.publisher"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:otherwise>
                    </c:choose>
                    </c:when>
                    <c:otherwise>
                    <th>
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=publisher&dir=asc">
                                    <fmt:message key="books.common.label.publisher"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=publisher&dir=asc">
                                    <fmt:message key="books.common.label.publisher"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:otherwise>
                    </c:choose>

                    <c:choose>
                    <c:when test="${orderBy eq 'pages'}">
                    <c:choose>
                    <c:when test="${dir eq 'asc'}">
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=pages&dir=desc">
                                    <fmt:message key="books.common.label.pages"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=pages&dir=desc">
                                    <fmt:message key="books.common.label.pages"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>

                    </th>
                    </c:when>
                    <c:otherwise>
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=pages&dir=asc">
                                    <fmt:message key="books.common.label.pages"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=pages&dir=asc">
                                    <fmt:message key="books.common.label.pages"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>

                    </th>
                    </c:otherwise>
                    </c:choose>
                    </c:when>
                    <c:otherwise>
                    <th>
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=pages&dir=asc">
                                    <fmt:message key="books.common.label.pages"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=pages&dir=asc">
                                    <fmt:message key="books.common.label.pages"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:otherwise>
                    </c:choose>

                    <c:choose>
                    <c:when test="${orderBy eq 'publicationDate'}">
                    <c:choose>
                    <c:when test="${dir eq 'asc'}">
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=publicationDate&dir=desc">
                                    <fmt:message key="books.common.label.publication_date"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=publicationDate&dir=desc">
                                    <fmt:message key="books.common.label.publication_date"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>

                    </th>
                    </c:when>
                    <c:otherwise>
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=publicationDate&dir=asc">
                                    <fmt:message key="books.common.label.publication_date"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=publicationDate&dir=asc">
                                    <fmt:message key="books.common.label.publication_date"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>

                    </th>
                    </c:otherwise>
                    </c:choose>
                    </c:when>
                    <c:otherwise>
                    <th>
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=publicationDate&dir=asc">
                                    <fmt:message key="books.common.label.publication_date"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=publicationDate&dir=asc">
                                    <fmt:message key="books.common.label.publication_date"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>

                    </th>
                    </c:otherwise>
                    </c:choose>

                    <c:choose>
                    <c:when test="${orderBy eq 'copies'}">
                    <c:choose>
                    <c:when test="${dir eq 'asc'}">
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=copies&dir=desc">
                                    <fmt:message key="books.common.label.available"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=copies&dir=desc">
                                    <fmt:message key="books.common.label.available"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:when>
                    <c:otherwise>
                    <th class="active">

                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=copies&dir=asc">
                                    <fmt:message key="books.common.label.available"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=copies&dir=asc">
                                    <fmt:message key="books.common.label.available"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>

                    </th>
                    </c:otherwise>
                    </c:choose>
                    </c:when>
                    <c:otherwise>
                    <th>
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=copies&dir=asc">
                                    <fmt:message key="books.common.label.available"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=copies&dir=asc">
                                    <fmt:message key="books.common.label.available"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>

                    </th>
                    </c:otherwise>
                    </c:choose>

                    <sec:authorize access="hasRole('ADMIN')">
                    <c:choose>
                    <c:when test="${orderBy eq 'removed'}">
                    <c:choose>
                    <c:when test="${dir eq 'asc'}">
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=removed&dir=desc">
                                    <fmt:message key="books.admin.label.removed"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=removed&dir=desc">
                                    <fmt:message key="books.admin.label.removed"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:when>
                    <c:otherwise>
                    <th class="active">

                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=removed&dir=asc">
                                    <fmt:message key="books.admin.label.removed"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=removed&dir=asc">
                                    <fmt:message key="books.admin.label.removed"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:otherwise>
                    </c:choose>
                    </c:when>
                    <c:otherwise>
                    <th>

                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&orderBy=removed&dir=asc">
                                    <fmt:message key="books.admin.label.removed"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?orderBy=removed&dir=asc">
                                    <fmt:message key="books.admin.label.removed"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:otherwise>
                    </c:choose>
                    <th>
                        <fmt:message key="books.admin.action.update"/>
                    </th>
                    </sec:authorize>

                    <sec:authorize access="hasRole('USER')">
                    <th><fmt:message key="user.books.label.order.book"/></th>
                    </sec:authorize>
                    <%--                    <c:if test="${sessionScope.user.role eq 'USER'}">--%>
                    <%--                    <th><fmt:message key="user.books.label.order.book"/></th>--%>
                    <%--                    </c:if>--%>


                    <%--                    <th><fmt:message key="books.common.label.available"/> <i class="fa fa-sort" aria-hidden="true"></i></th>--%>
                    <%--                </tr>--%>
                    <c:forEach var="booksList" items="${requestScope.booksList.content}" varStatus="loop">
                <tr>
                    <td> ${loop.count + (requestScope.booksList.pageable.pageNumber) * requestScope.booksList.size} </td>
                    <td> ${booksList.title} </td>
                    <td> ${booksList.genre.title} </td>
                    <td> ${booksList.author.firstName} ${booksList.author.lastName}</td>
                    <td> ${booksList.publisher.title} </td>
                    <td> ${booksList.pages} </td>
                        <%--                    <td> ${custom:formatDateTime(booksList.publicationDate,"dd MMM yyyy", language)} </td>--%>
                    <td> ${booksList.publicationDate} </td>

                    <td>
                        <c:choose>
                            <c:when test="${booksList.copies gt 0}">
                                ${booksList.copies}
                            </c:when>
                            <c:otherwise>
                                <fmt:message key="books.common.unavailable"/>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <sec:authorize access="hasRole('ADMIN')">
                        <c:choose>
                            <c:when test="${booksList.isRemoved}">
                                <td class="removed-book">
                                    <style>
                                        .removed-book:hover a p.label:after {
                                            content: '<fmt:message key="books.admin.action.restore"/>';
                                        }

                                        .removed-book:hover a p.label span {
                                            display: none;
                                        }
                                    </style>
                                    <div class="removed-book-div">
                                        <a class="remove-link"
                                           onclick="renewBook(${booksList.bookId})" href="#">
                                            <p class="label"><span class="align"><fmt:message
                                                    key="books.admin.msg.removed"/></span></p>
                                        </a>
                                    </div>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td class="present-book">
                                    <style>
                                        .present-book:hover a p.label:after {
                                            content: '<fmt:message key="books.admin.action.remove"/>';
                                        }

                                        .present-book:hover a p.label span {
                                            display: none;
                                        }
                                    </style>
                                    <div class="removed-book-div">
                                        <a class="remove-link" onclick="removeBook(${booksList.bookId})"
                                           href="#">
                                            <p class="label"><span class="align"><fmt:message
                                                    key="books.admin.msg.present"/></span></p>
                                        </a>
                                    </div>
                                </td>
                            </c:otherwise>
                        </c:choose>

                        <td>
                            <div class="update-book-div">
                                <a class="remove-link"
                                   href="/books/update/${booksList.bookId}">
                                    <fmt:message key="books.admin.action.update"/>
                                </a>
                            </div>

                        </td>
                    </sec:authorize>


                    <sec:authorize access="hasRole('USER')">
                        <c:choose>
                            <c:when test="${booksList.copies gt 0}">
                                <td class="order-book">
                                    <a class="order-book-link" style="height: 100%; width: 100%; text-align: center"
                                       href="controller?command=order_book_redirect&book_id=${booksList.bookId}">
                                        <fmt:message key="user.books.action.order.book"/>
                                    </a>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td class="order-book-impossible">
                                    <div class="order-book-div">
                                        <fmt:message key="books.common.unavailable"/>
                                    </div>
                                </td>
                            </c:otherwise>
                        </c:choose>
                    </sec:authorize>
                </tr>
                </c:forEach>
            </table>


        </div>
        <c:if test="${requestScope.booksList.totalPages != 0}">
            <div class="pages_container">
                    <%--For displaying Previous link except for the 1st page --%>
                <c:if test="${requestScope.booksList.pageable.pageNumber != 0}">
                    <c:choose>
                        <c:when test="${searchContent != null}">
                            <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&page=${requestScope.booksList.pageable.pageNumber - 1}&orderBy=${orderBy}&dir=${dir}">&laquo;</a>
                        </c:when>
                        <c:otherwise>
                            <a href="books?page=${requestScope.booksList.pageable.pageNumber - 1}&orderBy=${orderBy}&dir=${dir}">&laquo;</a>
                        </c:otherwise>
                    </c:choose>
                </c:if>
                    <%--For displaying Page numbers.
                        The when condition does not display a link for the current page--%>
                <c:forEach begin="0" end="${requestScope.booksList.totalPages - 1}" var="i">
                    <c:choose>
                        <c:when test="${requestScope.booksList.pageable.pageNumber eq i}">
                            <c:choose>
                                <c:when test="${searchContent != null}">
                                    <a class="active"
                                       href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&page=${i}&orderBy=${orderBy}&dir=${dir}">${i + 1}</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="books?page=${i}&orderBy=${orderBy}&dir=${dir}"
                                       class="active"> ${i + 1}</a>
                                </c:otherwise>
                            </c:choose>

                        </c:when>
                        <c:otherwise>
                            <%--                        <a href="books?page=${i}&orderBy=${orderBy}&dir=${dir}">${i + 1}</a>--%>
                            <c:choose>
                                <c:when test="${searchContent != null}">
                                    <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&page=${i}&orderBy=${orderBy}&dir=${dir}">${i + 1}</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="books?page=${i}&orderBy=${orderBy}&dir=${dir}">${i + 1}</a>
                                </c:otherwise>
                            </c:choose>

                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                    <%--For displaying Next link --%>
                <c:if test="${requestScope.booksList.pageable.pageNumber lt requestScope.booksList.totalPages - 1}">
                    <%--                <a href="books?page=${requestScope.booksList.pageable.pageNumber + 1}&orderBy=${orderBy}&dir=${dir}">&raquo;</a>--%>
                    <c:choose>
                        <c:when test="${searchContent != null}">
                            <a href="/books/search?searchBy=${requestScope.searchBy}&searchContent=${searchContent}&page=${requestScope.booksList.pageable.pageNumber + 1}&orderBy=${orderBy}&dir=${dir}">&raquo;</a>
                        </c:when>
                        <c:otherwise>
                            <a href="books?page=${requestScope.booksList.pageable.pageNumber + 1}&orderBy=${orderBy}&dir=${dir}">&raquo;</a>
                        </c:otherwise>
                    </c:choose>

                </c:if>

            </div>
        </c:if>

    </div>
</div>


<jsp:include page="footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    function removeBook(bookId) {
        let csrfToken = $("meta[name='_csrf']").attr("content");
        let csrfHeader = $("meta[name='_csrf_header']").attr("content");

        $.ajax({
            type: "PATCH",
            url: "/api/v1/books/" + bookId,
            data: {
                isRemoved: true
            },
            success: function () {
                location.reload();
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            }
        });
    }

    function renewBook(bookId) {
        let csrfToken = $("meta[name='_csrf']").attr("content");
        let csrfHeader = $("meta[name='_csrf_header']").attr("content");

        $.ajax({
            type: "PATCH",
            url: "/api/v1/books/" + bookId,
            data: {
                isRemoved: false
            },
            success: function () {
                location.reload();
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            }
        });
    }
</script>

</body>
</html>

