<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<fmt:setLocale value="${sessionScope.language}"/>
<fmt:setBundle basename="locale"/>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/footer.css"/>
<div class="footer">
    <div class="footer-elements">
        <a href="${pageContext.request.contextPath}/controller?command=home"><fmt:message
                key="footer.common.about"/></a>
        <a href="https://github.com/alex-ztdev">GitHub</a>
    </div>
</div>
