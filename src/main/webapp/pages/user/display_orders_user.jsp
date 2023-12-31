<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="custom" uri="/WEB-INF/custom.tld" %>


<c:set var="language"
       value="${not empty param.language ? param.language : not empty sessionScope.language ? sessionScope.language : 'en'}"
       scope="session"/>

<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="locale"/>

<c:set var="currPage" scope="request"
       value="${requestScope.ordersList.pageable.pageNumber}"/>


<!DOCTYPE>
<html lang="${language}">
<head>
    <meta charset="UTF-8"/>
    <title>Orders</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/books.css"/>
    <script src="https://kit.fontawesome.com/e83e8567ce.js" crossorigin="anonymous"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/static/img/icon/icon.ico">
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<sec:csrfMetaTags/>
<div class="container">
    <div class="main-content">
        <div class="top-row">
            <sec:authorize access="hasRole('USER')">
                <p class="users-orders-title"><fmt:message key="user.orders.orders.title"/></p>
            </sec:authorize>
        </div>
        <div class="books_list_container">
            <table class="books_table" aria-label="orders-table">

                <tr>
                    <th><fmt:message key="common.label.counter"/></th>
                    <th><fmt:message key="orders.common.order.id"/></th>
                    <th><fmt:message key="orders.common.book.title"/></th>
                    <th><fmt:message key="orders.common.order.start.date"/></th>
                    <th><fmt:message key="orders.common.order.end.date"/></th>
                    <th><fmt:message key="orders.common.order.place"/></th>
                    <th><fmt:message key="orders.common.returned"/></th>
                    <th><fmt:message key="orders.common.fine"/></th>
                </tr>
                <c:forEach var="orders" items="${requestScope.ordersList.content}" varStatus="loop">

                <c:choose>
                <c:when test="${orders.fine != 0.0 and orders.returnDate == null}">
                <tr class="overdue-tr" style="background: #d72d2d;">
                    </c:when>
                    <c:when test="${orders.returnDate != null}">
                <tr class="returned-tr" style="background: #18a223;">
                    </c:when>
                    <c:otherwise>
                <tr>
                    </c:otherwise>
                    </c:choose>


                    <td> ${loop.count + (requestScope.ordersList.pageable.pageNumber) * requestScope.ordersList.size} </td>
                    <td> ${orders.orderId} </td>
                    <td> ${orders.book.title} </td>

                    <td> ${custom:formatLocalDateTime(orders.startDate,"dd MMM yyyy HH:mm", language)} </td>
                    <td> ${custom:formatLocalDateTime(orders.endDate,"dd MMM yyyy HH:mm", language)} </td>


                    <c:choose>
                        <c:when test="${orders.onSubscription}">
                            <td><fmt:message key="orders.common.order.subscription"/></td>
                        </c:when>
                        <c:otherwise>
                            <td><fmt:message key="orders.common.order.in.reading.hall"/></td>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${orders.returnDate != null}">
                            <td> ${custom:formatLocalDateTime(orders.endDate,"dd MMM yyyy hh:mm", language)} </td>
                        </c:when>
                        <c:when test="${orders.returnDate == null and orders.fine != 0.0}">
                            <td><fmt:message key="orders.common.returned.overdue"/></td>
                        </c:when>
                        <c:otherwise>
                            <td><fmt:message key="orders.common.not.returned"/></td>
                        </c:otherwise>
                    </c:choose>

                    <td>${orders.fine} $</td>
                    </c:forEach>
                </tr>
            </table>


        </div>
        <c:if test="${requestScope.ordersList.totalPages > 0}">
            <div class="pages_container">
                    <%--For displaying Previous link except for the 1st page --%>
                <c:if test="${currPage != 0}">
                    <a href="/orders/user?page=${currPage - 1}">&laquo;</a>
                </c:if>
                    <%--For displaying Page numbers.
                        The when condition does not display a link for the current page--%>
                <c:forEach begin="0" end="${requestScope.ordersList.totalPages - 1 }" var="i">
                    <c:choose>
                        <c:when test="${currPage eq i}">
                            <a href="/orders/user?page=${i}"
                               class="active"> ${i + 1}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/orders/user?page=${i}">${i + 1}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                    <%--For displaying Next link --%>
                <c:if test="${currPage + 1 lt requestScope.ordersList.totalPages}">
                    <a href="/orders/user?page=${currPage + 1}">&raquo;</a>
                </c:if>

            </div>

        </c:if>

    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
</body>

<%--<script>--%>
<%--    function returnOrder(id) {--%>
<%--        let csrfToken = $("meta[name='_csrf']").attr("content");--%>
<%--        let csrfHeader = $("meta[name='_csrf_header']").attr("content");--%>

<%--        $.ajax({--%>
<%--            type: "POST",--%>
<%--            url: "/api/orders/fulfill/" + id,--%>
<%--            success: function () {--%>
<%--                location.reload();--%>
<%--            },--%>
<%--            beforeSend: function (xhr) {--%>
<%--                xhr.setRequestHeader(csrfHeader, csrfToken);--%>
<%--            }--%>
<%--        });--%>
<%--    }--%>
<%--</script>--%>
</html>
