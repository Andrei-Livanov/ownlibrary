<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link href="<c:url value="/res/style.css"/>" rel="stylesheet" type="text/css"/>
    <link rel="icon" type="image/png" href="<c:url value="/res/59_85246.png"/>"/>
    <c:choose>
        <c:when test="${empty book.title}">
            <title>Add</title>
        </c:when>
        <c:otherwise>
            <title>Edit</title>
        </c:otherwise>
    </c:choose>
</head>
<body class="page2">
<c:url value="/add" var="addUrl"/>
<c:url value="/edit" var="editUrl"/>
<form class="style" action="${empty book.title ? addUrl : editUrl}" name="book" method="POST">
    <c:choose>
        <c:when test="${!empty book.title}">
            <p class="heading">Edit book</p>
            <input type="hidden" name="id" value="${book.id}">
        </c:when>
        <c:otherwise>
            <p class="heading">Add new book</p>
        </c:otherwise>
    </c:choose>
    <p><label>
        <input type="text" name="title" placeholder="title" value="${book.title}" maxlength="100" required autofocus
               pattern="^[^\s]+(\s.*)?$">
    </label>
    <p><label>
        <input type="text" name="author" placeholder="author" value="${book.author}" maxlength="40" required>
    </label>
    <p><label>
        <input type="text" name="genre" placeholder="genre" value="${book.genre}" maxlength="40" required>
    </label>
    <p class="checkbox">
        <label for="read">read
            <c:if test="${book.read == true}">
                <input type="checkbox" name="read" id="read" value="${book.read}" checked>
            </c:if>
            <c:if test="${book.read != true}">
                <input type="checkbox" name="read" id="read">
            </c:if>
            <span class="checkbox-common checkbox-no">no</span>
            <span class="checkbox-common checkbox-yes">yes</span>
        </label>
    </p>
    <p>
        <c:set value="add" var="add"/>
        <c:set value="edit" var="edit"/>
        <input type="submit" value="${empty book.title ? add : edit}">
    </p>
    <p class="heading">${message}</p>
</form>
</body>
</html>
