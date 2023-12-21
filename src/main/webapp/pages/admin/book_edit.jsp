<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty sessionScope.language ? sessionScope.language : 'en'}"
       scope="session"/>

<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="locale"/>

<html lang="${language}">
<head>
    <meta charset="UTF-8"/>
    <title>Library Main</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/book_edit.css"/>
    <link rel="icon" href="${pageContext.request.contextPath}/static/img/icon/icon.ico">
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<sec:csrfMetaTags/>
<div class="container">
    <div class="main-content">
        <p hidden="hidden" id ="success-update" class="success-msg"><fmt:message key="admin.books.edit.success.msg.updated"/><br></p>

        <c:if test="${not empty requestScope.successfully_added}">
            <p class="success-msg"><fmt:message key="admin.books.edit.success.msg.added"/></p><br>
        </c:if>
        <c:if test="${not empty requestScope.invalid_book_data}">
            <p class="error-msg"><fmt:message key="admin.books.edit.error.msg.invalid.data"/></p><br>
        </c:if>
        <c:if test="${not empty requestScope.book_exists}">
            <p class="error-msg"><fmt:message key="admin.books.edit.error.msg.already.exists"/></p>
        </c:if>


        <form id="book-form" action="" method="post">
            <c:choose>
                <c:when test="${not empty requestScope.operation_type}">
                    <input name="command" type="hidden" value="update-book">
                </c:when>
                <c:otherwise>
                    <input name="command" type="hidden" value="add-book">
                </c:otherwise>
            </c:choose>

            <input name="bookId" type="hidden" value="${requestScope.book.bookId}">
            <div class="elem-group">
                <label class="book-edit-label" for="title"><fmt:message
                        key="admin.books.edit.form.label.book.title"/></label>
                <input
                        type="text"
                        id="title"
                        name="title"
                        class="edit-book-input"
                        placeholder="<fmt:message key="admin.books.edit.form.placeholder.title"/>"
                        pattern="^['a-zA-Z?!,.а-яА-ЯёЁ0-9\s\-:]{1,350}$"
                        title="<fmt:message key="admin.books.edit.form.validation.msg.title"/>"
                        value="${requestScope.book.title}"
                        required
                />
                <div class="error-msg-container"></div>
            </div>

            <div class="elem-group inlined">
                <label class="book-edit-label" for="firstName"><fmt:message
                        key="admin.books.edit.form.label.author.first.name"/></label>
                <input type="hidden" name="authorId" value="${requestScope.book.author.id}"/>
                <input
                        type="text"
                        id="firstName"
                        class="edit-book-input"
                        name="firstName"
                        placeholder="<fmt:message key="admin.books.edit.form.placeholder.first.name"/>"
                        pattern="^['a-zA-Z?а-яА-ЯёЁ]{1,50}$"
                        title="<fmt:message key="admin.books.edit.form.validation.msg.name"/>"
                        value="${requestScope.book.author.firstName}"
                        required
                />
                <div class="error-msg-container"></div>
            </div>
            <div class="elem-group inlined">
                <label class="book-edit-label" for="secondName"><fmt:message
                        key="admin.books.edit.form.label.author.second.name"/></label>
                <input
                        type="text"
                        id="secondName"
                        class="edit-book-input"
                        name="lastName"
                        placeholder="<fmt:message key="admin.books.edit.form.placeholder.second.name"/>"
                        pattern="^['a-zA-Z?а-яА-ЯёЁ]{1,50}$"
                        title="<fmt:message key="admin.books.edit.form.validation.msg.name"/>"
                        value="${requestScope.book.author.lastName}"
                        required
                />
                <div class="error-msg-container"></div>
            </div>
            <div class="elem-group inlined">
                <label class="book-edit-label" for="genre-selection"><fmt:message
                        key="admin.books.edit.form.label.select.genre"/></label>
                <select class="book-edit-select" id="genre-selection" name="genreId" required>
                    <c:if test="${not empty requestScope.book.genre.title }">
                        <option value="${requestScope.book.genre.id}">${requestScope.book.genre.title}</option>
                    </c:if>
                    <c:forEach var="genres" items="${requestScope.genres}" varStatus="loop">
                        <option value="${genres.id}">${genres.title}</option>
                    </c:forEach>

                </select>
            </div>
            <div class="elem-group inlined">
                <label class="book-edit-label" for="publisher-selection"><fmt:message
                        key="admin.books.edit.form.label.select.publisher"/></label>
                <select class="book-edit-select" id="publisher-selection" name="publisherId" required>
                    <c:if test="${not empty requestScope.book.publisher.title }">
                        <option value="${requestScope.book.publisher.id}">${requestScope.book.publisher.title}</option>
                    </c:if>
                    <c:forEach var="publishers" items="${requestScope.publishers}" varStatus="loop">
                        <option value="${publishers.id}">${publishers.title}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="elem-group">
                <label class="book-edit-label" for="copies"><fmt:message
                        key="admin.books.edit.form.label.copies"/></label>
                <input
                        type="number"
                        class="edit-book-input"
                        id="copies"
                        name="copies"
                        placeholder="2"
                        min="0"
                        value="${requestScope.book.copies}"
                        required
                />
                <div class="error-msg-container"></div>
            </div>

            <hr/>
            <div class="elem-group inlined">
                <label class="book-edit-label" for="pages"><fmt:message
                        key="admin.books.edit.form.label.pages"/></label>
                <input
                        class="edit-book-input"
                        type="number"
                        id="pages"
                        name="pages"
                        placeholder="100"
                        min="1"
                        value="${requestScope.book.pages}"
                        required
                />
                <div class="error-msg-container"></div>
            </div>

            <div class="elem-group inlined">
                <label class="book-edit-label" for="publication-date"><fmt:message
                        key="admin.books.edit.form.label.publication.date"/></label>
                <input
                        class="edit-book-input"
                        type="date"
                        id="publication-date"
                        name="publicationDate"
                        value="${requestScope.book.publicationDate}"
                        required
                        max="${LocalDate.now()}"
                />
            </div>
            <button id="edit-book-button" type="submit" style="margin-left: 43%; padding: 10px 20px"><fmt:message
                    key="admin.books.edit.form.label.submit.btn"/></button>
        </form>
    </div>
</div>
<jsp:include page="../common/footer.jsp"/>
</body>
<script>
    $(document).ready(function () {
        function formToJson(form) {
            const formData = {};

            $(form).find('input, select').each(function () {
                const fieldName = $(this).attr('name');
                const fieldValue = $(this).val();

                // Split author names and create inner JSON
                if (fieldName === 'firstName' || fieldName === 'lastName' || fieldName === 'authorId') {
                    if (!formData['author']) {
                        formData['author'] = {};
                    }
                    formData['author'][fieldName] = fieldValue;
                } else {
                    formData[fieldName] = fieldValue;
                }
            });
            return JSON.stringify(formData);
        }

        // Assuming you have a button or event triggering the form submission
        $("#book-form").on("submit", function (event) {
            if (this.checkValidity()) {
                event.preventDefault();
                let formData = formToJson(this);

                let operationType = window.location.pathname;
                console.log(operationType);

                if (operationType.includes("/books/update") ) {
                    console.log("Update");
                    update(formData);
                } else if (operationType.includes("/books/create")) {
                    console.log("Create");
                    create(formData);
                } else {
                    console.log("Not Supported operation!");
                    window.location.href = "/error/400";
                }
            } else {
                // If the form is not valid, the default behavior will occur
                console.log("Form is not valid!");
            }
        });

        function update(formData) {
            let csrfToken = $("meta[name='_csrf']").attr("content");
            let csrfHeader = $("meta[name='_csrf_header']").attr("content");


            $.ajax({
                type: "PUT",  // Adjust the method if your form uses GET or another method
                url: "/api/v1/books/${requestScope.book.bookId}",  // Replace with your actual endpoint
                data: formData,
                contentType: "application/json",
                dataType: "json",
                success: function (response) {
                    console.log("Form submitted successfully:", response);
                },
                error: function (error) {
                    // Handle the error response here
                    console.error("Error submitting form:", error);
                },
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                }
            });
        }

        function create(formData) {
            let csrfToken = $("meta[name='_csrf']").attr("content");
            let csrfHeader = $("meta[name='_csrf_header']").attr("content");


            $.ajax({
                type: "POST",  // Adjust the method if your form uses GET or another method
                url: "/api/v1/books",  // Replace with your actual endpoint
                data: formData,
                success: function (response) {
                    console.log("Form submitted successfully:", response);
                },
                error: function (error) {
                    console.error("Error submitting form:", error);
                },
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                }
            });
        }
    });
</script>
</html>
