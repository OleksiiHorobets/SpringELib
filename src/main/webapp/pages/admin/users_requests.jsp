<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="custom" uri="/WEB-INF/custom.tld" %>


<c:set var="language"
       value="${not empty param.language ? param.language : not empty sessionScope.language ? sessionScope.language : 'en'}"
       scope="session"/>

<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="locale"/>


<!DOCTYPE>
<html lang="${language}">
<head>
    <meta charset="UTF-8"/>
    <title>Requests</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/requests.css"/>
    <script src="https://kit.fontawesome.com/e83e8567ce.js" crossorigin="anonymous"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/static/img/icon/icon.ico">
</head>

<body>
<jsp:include page="../common/header.jsp"/>
<sec:csrfMetaTags/>
<div class="container">
    <div class="main-content">
        <div class="top-row">
            <p class="users-orders-title" style="text-align: center"><fmt:message
                    key="admin.orders.requests.title"/></p>
        </div>
        <div class="orders_list_container">
            <table class="orders_table" aria-label="orders-table">
                <tr>
                    <th><fmt:message key="common.label.counter"/></th>

                    <th><fmt:message key="orders.common.order.id"/></th>
                    <th><fmt:message key="orders.common.user.id"/></th>
                    <th><fmt:message key="orders.common.user.name"/></th>

                    <th><fmt:message key="orders.common.book.title"/></th>
                    <th><fmt:message key="orders.common.order.placed.date"/></th>
                    <th><fmt:message key="orders.common.order.place"/></th>
                    <th><fmt:message key="orders.common.status"/></th>
                </tr>
                <c:forEach var="orders" items="${requestScope.requestsList.content}" varStatus="loop">
                    <c:choose>
                        <c:when test="${orders.orderStatus eq 'REJECTED'}">
                            <tr class="rejected-tr" style="background: #8f8f8f;">
                        </c:when>
                        <c:otherwise>
                            <tr>
                        </c:otherwise>
                    </c:choose>
                    <td> ${loop.count + (requestScope.requestsList.pageable.pageNumber) * requestScope.requestsList.size} </td>
                    <td> ${orders.orderId} </td>
                    <td> ${orders.user.id}</td>
                    <td> ${orders.user.username}</td>
                    <td> ${orders.book.title} </td>
                    <td> ${custom:formatLocalDateTime(orders.startDate,"dd MMM yyyy HH:mm", language)} </td>

                    <c:choose>
                        <c:when test="${orders.onSubscription}">
                            <td><fmt:message key="orders.common.order.subscription"/></td>
                        </c:when>
                        <c:otherwise>
                            <td><fmt:message key="orders.common.order.in.reading.hall"/></td>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${orders.orderStatus eq 'REJECTED'}">
                            <td><fmt:message key="orders.common.status.rejected"/></td>
                        </c:when>
                        <c:when test="${orders.orderStatus eq 'ACCEPTED'}">
                            <td><fmt:message key="orders.common.status.accepted"/></td>
                        </c:when>
                        <c:when test="${orders.orderStatus eq 'PROCESSING'}">
                            <td><fmt:message key="orders.common.status.processing"/></td>
                        </c:when>
                    </c:choose>

                    <c:choose>
                        <c:when test="${orders.orderStatus eq 'PROCESSING'}">
                            <td class="accept-order">
                                <div>
                                    <a href="#" onclick="updateOrderStatus(${orders.orderId}, 'ACCEPTED')">
                                        <fmt:message key="orders.common.action.accept"/>
                                    </a>
                                </div>
                            </td>
                            <td class="decline-order">
                                <div>
                                    <a href="#" onclick="updateOrderStatus(${orders.orderId}, 'REJECTED')">
                                        <fmt:message key="orders.common.action.decline"/>
                                    </a>
                                </div>
                            </td>
                        </c:when>
                    </c:choose>
                    </tr>
                </c:forEach>
            </table>


        </div>
        <c:if test="${requestScope.requestsList.totalPages > 0}">
            <c:set var="currPage" scope="request"
                   value="${requestScope.requestsList.pageable.pageNumber}"/>
            <div class="pages_container">
                    <%--For displaying Previous link except for the 1st page --%>
                <c:if test="${currPage != 0}">
                    <a href="/orders/admin/requests?page=${currPage - 1}">&laquo;</a>
                </c:if>
                    <%--For displaying Page numbers.
                        The when condition does not display a link for the current page--%>
                <c:forEach begin="0" end="${requestScope.requestsList.totalPages - 1 }" var="i">
                    <c:choose>
                        <c:when test="${currPage eq i}">
                            <a href="/orders/admin/requests?page=${i}"
                               class="active"> ${i + 1}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/orders/admin/requests?page=${i}">${i + 1}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                    <%--For displaying Next link --%>
                <c:if test="${currPage + 1 lt requestScope.requestsList.totalPages}">
                    <a href="/orders/admin/requests?page=${currPage + 1}">&raquo;</a>
                </c:if>
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
</body>

<script>
    function updateOrderStatus(id, status) {
        let csrfToken = $("meta[name='_csrf']").attr("content");
        let csrfHeader = $("meta[name='_csrf_header']").attr("content");

        $.ajax({
            type: "PATCH",
            url: "/api/orders/status/" + id + "?orderStatus=" + status,
            success: function () {
                location.reload();
            },
            error: function (error) {
                console.log("Operation failed!", error);
                window.location.href = "/error/400";
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            }
        });
    }
</script>
</html>

