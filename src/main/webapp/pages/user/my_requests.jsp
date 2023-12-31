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
            <%--            <p style="color: white; font-size: 20px">${requestScope}</p>--%>
            <p class="users-orders-title" style="text-align: center" style="justify-self: center"><fmt:message
                    key="my.orders.requests.title"/></p>
            <c:if test="${not empty requestScope.msg}">
                <p class="success-msg" style="margin-left: 200px"><fmt:message
                        key="user.orders.success.msg"/></p>
            </c:if>
        </div>
        <div class="orders_list_container">
            <table class="orders_table" aria-label="orders-table">
                <tr>
                    <th><fmt:message key="common.label.counter"/></th>
                    <th><fmt:message key="orders.common.order.id"/></th>
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

                    <sec:authorize access="hasRole('USER')">
                        <c:if test="${orders.orderStatus eq 'PROCESSING'}">
                            <td class="decline-order">
                                <div>
                                    <a href="#" onclick="cancelOrder(${orders.orderId})">
                                        <fmt:message key="orders.common.action.cancel"/>
                                    </a>
                                </div>
                            </td>
                        </c:if>
                    </sec:authorize>

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
                    <a href="/orders/user/requests?page=${currPage - 1}">&laquo;</a>
                </c:if>
                    <%--For displaying Page numbers.
                        The when condition does not display a link for the current page--%>
                <c:forEach begin="0" end="${requestScope.requestsList.totalPages - 1 }" var="i">
                    <c:choose>
                        <c:when test="${currPage eq i}">
                            <a href="/orders/user/requests?page=${i}"
                               class="active"> ${i + 1}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/orders/user/requests?page=${i}">${i + 1}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                    <%--For displaying Next link --%>
                <c:if test="${currPage + 1 lt requestScope.requestsList.totalPages}">
                    <a href="/orders/user/requests?page=${currPage + 1}">&raquo;</a>
                </c:if>

            </div>

        </c:if>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
</body>
<script>
    function cancelOrder(orderId) {
        // Display a confirmation dialog
        let userCancelled = !window.confirm("Are you sure you want to cancel this order?");
        console.log("Order id: ", orderId);
        // Check if the user cancelled
        if (userCancelled) {
            console.log("Cancellation operation cancelled by user.");
            return; // Do nothing if the user cancels
        }

        let csrfToken = $("meta[name='_csrf']").attr("content");
        let csrfHeader = $("meta[name='_csrf_header']").attr("content");

        $.ajax({
            type: "DELETE",
            url: "/orders/cancel/" + orderId,
            success: function (response) {
                console.log("Canceled successfully:", response);
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
