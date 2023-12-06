<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%--<%@ taglib prefix="custom" uri="/WEB-INF/custom.tld" %>--%>

<c:set var="order_by" scope="request" value="${requestScope.order_by}"/>
<c:set var="dir" scope="request" value="${requestScope.dir}"/>
<c:set var="userRole" scope="request" value="${sessionScope.user.role}"/>
<c:set var="searchContent" scope="request" value="${requestScope.search}"/>

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
            <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                <a href="controller?command=add-book-redirect&add_new_pressed=true" class="books-add-new">
                    <fmt:message key="admin.books.edit.form.title.add"/>
                </a>
            </c:if>
        </div>
        <div class="books_list_container">
            <table class="books_table">
                <tr>
                    <th><fmt:message key="common.label.counter"/></th>

                    <c:choose>
                    <c:when test="${order_by eq 'title'}">
                    <c:choose>
                    <c:when test="${dir eq 'asc'}">
                    <th class="active">

                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=title&dir=desc">
                                    <fmt:message key="books.common.label.book_title"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=title&dir=desc">
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
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=title&dir=asc">
                                    <fmt:message key="books.common.label.book_title"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=title&dir=asc">
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
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=title&dir=asc">
                                    <fmt:message key="books.common.label.book_title"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=title&dir=asc">
                                    <fmt:message key="books.common.label.book_title"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:otherwise>
                    </c:choose>

                    <c:choose>
                    <c:when test="${order_by eq 'genre'}">
                    <c:choose>
                    <c:when test="${dir eq 'asc'}">


                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=genre&dir=desc">
                                    <fmt:message key="books.common.label.genre"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=genre&dir=desc">
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
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=genre&dir=asc">
                                    <fmt:message key="books.common.label.genre"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=genre&dir=asc">
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
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=genre&dir=asc">
                                    <fmt:message key="books.common.label.genre"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=genre&dir=asc">
                                    <fmt:message key="books.common.label.genre"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:otherwise>
                    </c:choose>

                    <c:choose>
                    <c:when test="${order_by eq 'author'}">
                    <c:choose>
                    <c:when test="${dir eq 'asc'}">
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=author&dir=desc">
                                    <fmt:message key="books.common.label.author"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=author&dir=desc">
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
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=author&dir=asc">
                                    <fmt:message key="books.common.label.author"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=author&dir=asc">
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
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=author&dir=asc">
                                    <fmt:message key="books.common.label.author"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=author&dir=asc">
                                    <fmt:message key="books.common.label.author"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:otherwise>
                    </c:choose>

                    <c:choose>
                    <c:when test="${order_by eq 'publisher'}">
                    <c:choose>
                    <c:when test="${dir eq 'asc'}">
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=publisher&dir=desc">
                                    <fmt:message key="books.common.label.publisher"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=publisher&dir=desc">
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
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=publisher&dir=asc">
                                    <fmt:message key="books.common.label.publisher"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=publisher&dir=asc">
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
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=publisher&dir=asc">
                                    <fmt:message key="books.common.label.publisher"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=publisher&dir=asc">
                                    <fmt:message key="books.common.label.publisher"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:otherwise>
                    </c:choose>

                    <c:choose>
                    <c:when test="${order_by eq 'pages'}">
                    <c:choose>
                    <c:when test="${dir eq 'asc'}">
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=pages&dir=desc">
                                    <fmt:message key="books.common.label.pages"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=pages&dir=desc">
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
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=pages&dir=asc">
                                    <fmt:message key="books.common.label.pages"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=pages&dir=asc">
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
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=pages&dir=asc">
                                    <fmt:message key="books.common.label.pages"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=pages&dir=asc">
                                    <fmt:message key="books.common.label.pages"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    </c:otherwise>
                    </c:choose>

                    <c:choose>
                    <c:when test="${order_by eq 'publicationDate'}">
                    <c:choose>
                    <c:when test="${dir eq 'asc'}">
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=publicationDate&dir=desc">
                                    <fmt:message key="books.common.label.publication_date"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=publicationDate&dir=desc">
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
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=publicationDate&dir=asc">
                                    <fmt:message key="books.common.label.publication_date"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=publicationDate&dir=asc">
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
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=publicationDate&dir=asc">
                                    <fmt:message key="books.common.label.publication_date"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=publicationDate&dir=asc">
                                    <fmt:message key="books.common.label.publication_date"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>

                    </th>
                    </c:otherwise>
                    </c:choose>

                    <c:choose>
                    <c:when test="${order_by eq 'copies'}">
                    <c:choose>
                    <c:when test="${dir eq 'asc'}">
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=copies&dir=desc">
                                    <fmt:message key="books.common.label.available"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=copies&dir=desc">
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
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=copies&dir=asc">
                                    <fmt:message key="books.common.label.available"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=copies&dir=asc">
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
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=copies&dir=asc">
                                    <fmt:message key="books.common.label.available"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=copies&dir=asc">
                                    <fmt:message key="books.common.label.available"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>

                    </th>
                    </c:otherwise>
                    </c:choose>

                    <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                    <c:choose>
                    <c:when test="${order_by eq 'removed'}">
                    <c:choose>
                    <c:when test="${dir eq 'asc'}">
                    <th class="active">
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=removed&dir=desc">
                                    <fmt:message key="books.admin.label.removed"/>
                                    <i class="fa fa-long-arrow-down" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=removed&dir=desc">
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
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=removed&dir=asc">
                                    <fmt:message key="books.admin.label.removed"/>
                                    <i class="fa fa-long-arrow-up" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=removed&dir=asc">
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
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&order_by=removed&dir=asc">
                                    <fmt:message key="books.admin.label.removed"/>
                                    <i class="fa fa-sort" aria-hidden="true"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?order_by=removed&dir=asc">
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

                    </c:if>
                    <c:if test="${sessionScope.user.role eq 'USER'}">
                    <th><fmt:message key="user.books.label.order.book"/></th>
                    </c:if>


                    <%--                    <th><fmt:message key="books.common.label.available"/> <i class="fa fa-sort" aria-hidden="true"></i></th>--%>
                    <%--                </tr>--%>
                    <c:forEach var="booksList" items="${requestScope.booksList.content}" varStatus="loop">
                <tr>
                    <td> ${loop.count + (requestScope.pageable.pageNumber) * requestScope.pageable.pageSize} </td>
                    <td> ${booksList.title} </td>
                    <td> ${booksList.genre} </td>
                    <td> ${booksList.author.firstName} ${booksList.author.lastName}</td>
                    <td> ${booksList.publisher.title} </td>
                    <td> ${booksList.pages} </td>
                        <%--                    <td> ${custom:formatDateTime(booksList.publicationDate,"dd MMM yyyy", language)} </td>--%>
                    <td> ${booksList.publicationDate} </td>

                    <td>
                            ${booksList.copies}
                            <%--                        <c:choose>--%>
                            <%--                            <c:when test="${booksList.copies gt 0}">--%>
                            <%--                                ${booksList.copies}--%>
                            <%--                            </c:when>--%>
                            <%--                            <c:otherwise>--%>
                            <%--                                <fmt:message key="books.common.unavailable"/>--%>
                            <%--                            </c:otherwise>--%>
                            <%--                        </c:choose>--%>
                    </td>

                    <c:if test="${userRole eq 'ADMIN'}">
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
                                           href="controller?command=restore-book&book_id=${booksList.bookId}">
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
                                        <a class="remove-link"
                                           href="controller?command=remove-book&book_id=${booksList.bookId}">
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
                                   href="controller?command=update-book-redirect&book_id=${booksList.bookId}">
                                    <fmt:message key="books.admin.action.update"/>
                                </a>
                            </div>

                        </td>
                    </c:if>
                    <c:if test="${userRole eq 'USER'}">
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

                    </c:if>
                </tr>
                </c:forEach>
            </table>


        </div>
        <div class="pages_container">
            <%--For displaying Previous link except for the 1st page --%>
            <c:if test="${requestScope.page != 1}">

                <c:choose>
                    <c:when test="${searchContent != null}">
                        <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&page=${requestScope.pageable.pageNumber}&order_by=${order_by}&dir=${dir}">&laquo;</a>
                    </c:when>
                    <c:otherwise>
                        <a href="books?page=${requestScope.pageable.pageNumber}&order_by=${order_by}&dir=${dir}">&laquo;</a>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <%--For displaying Page numbers.
                The when condition does not display a link for the current page--%>
            <c:forEach begin="1" end="${requestScope.totalPages}" var="i">
                <c:choose>
                    <c:when test="${requestScope.page eq i}">
                        <%--                        <a href="books?page=${i}&order_by=${order_by}&dir=${dir}"--%>
                        <%--                           class="active"> ${i}</a>--%>
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a class="active"
                                   href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&page=${i}&order_by=${order_by}&dir=${dir}">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?page=${i}&order_by=${order_by}&dir=${dir}"
                                   class="active"> ${i}</a>
                            </c:otherwise>
                        </c:choose>


                    </c:when>
                    <c:otherwise>
                        <%--                        <a href="books?page=${i}&order_by=${order_by}&dir=${dir}">${i}</a>--%>
                        <c:choose>
                            <c:when test="${searchContent != null}">
                                <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&page=${i}&order_by=${order_by}&dir=${dir}">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="books?page=${i}&order_by=${order_by}&dir=${dir}">${i}</a>
                            </c:otherwise>
                        </c:choose>

                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <%--For displaying Next link --%>
            <c:if test="${requestScope.page lt requestScope.totalPages}">
                <%--                <a href="books?page=${requestScope.page + 1}&order_by=${order_by}&dir=${dir}">&raquo;</a>--%>
                <c:choose>
                    <c:when test="${searchContent != null}">
                        <a href="controller?command=search-book&search_by=${requestScope.search_by}&search=${searchContent}&page=${requestScope.page + 1}&order_by=${order_by}&dir=${dir}">&raquo;</a>
                    </c:when>
                    <c:otherwise>
                        <a href="books?page=${requestScope.page + 1}&order_by=${order_by}&dir=${dir}">&raquo;</a>
                    </c:otherwise>
                </c:choose>

            </c:if>

        </div>

    </div>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>