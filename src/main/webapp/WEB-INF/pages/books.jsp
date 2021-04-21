<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Library</title>
    <link href="<c:url value="/res/style.css"/>" rel="stylesheet" type="text/css"/>
    <link rel="icon" type="image/png" href="<c:url value="/res/59_85246.png"/>"/>
</head>
<body class="page1">
<table class="style">
    <caption class="heading">My library</caption>
    <c:if test="${booksCount > 0}">
        <tr>
            <th class="left-side">№</th>
            <th style="width: 100%">title</th>
            <th>author</th>
            <th>genre</th>
            <th>read</th>
            <th colspan="2" class="right-side">action</th>
        </tr>
        <c:forEach var="book" items="${booksList}" varStatus="i">
            <tr>
                <td class="left-side">${i.index + 1 + (page - 1) * 10}</td>
                <td class="title">${book.title}</td>
                <td>${book.author}</td>
                <td>${book.genre}</td>
                <td>
                    <c:if test="${book.read == true}">
                        <span class="icon icon-watched" title="read"></span>
                    </c:if>
                </td>
                <td>
                    <a href="/edit/${book.id}">
                        <span class="icon icon-edit" title="edit"></span>
                    </a>
                </td>
                <td class="right-side">
                    <a href="/delete/${book.id}">
                        <span class="icon icon-delete" title="delete"></span>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </c:if>
    <c:if test="${booksCount == 0}">
        <tr>
            <td colspan="7" style="font-size: 150%" class="left-side right-side">
                the list is empty but you can add a new book
            </td>
        </tr>
    </c:if>
    <tr>
        <td colspan="7" class="left-side link right-side">
            <a style="margin-right: 70px; font-size: 100%" href="<c:url value="/add"/>">
                <span class="icon icon-add"></span>Add new book
            </a>
            <c:if test="${pagesCount > 1}">
                <c:set value="disabled" var="disabled"/>
                <c:set value="" var="active"/>
                <c:url value="/" var="url">
                    <c:param name="page" value="1"/>
                </c:url>
                <a class="${page == 1 ? disabled : active}" href="${url}">
                    &nbsp<span class="icon icon-first"></span>&nbsp
                </a>
                <c:url value="/" var="url">
                    <c:param name="page" value="${page - 1}"/>
                </c:url>
                <a class="${page == 1 ? disabled : active}" href="${url}">
                    &nbsp<span class="icon icon-prev"></span>&nbsp
                </a>

                <c:if test="${pagesCount <= 5}">
                    <c:set var="begin" value="1"/>
                    <c:set var="end" value="${pagesCount}"/>
                </c:if>
                <c:if test="${pagesCount > 5}">
                    <c:choose>
                        <c:when test="${page < 3}">
                            <c:set var="begin" value="1"/>
                            <c:set var="end" value="5"/>
                        </c:when>
                        <c:when test="${page > pagesCount - 2}">
                            <c:set var="begin" value="${pagesCount - 4}"/>
                            <c:set var="end" value="${pagesCount}"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="begin" value="${page - 2}"/>
                            <c:set var="end" value="${page + 2}"/>
                        </c:otherwise>
                    </c:choose>
                </c:if>

                <c:forEach begin="${begin}" end="${end}" step="1" varStatus="i">
                    <c:url value="/" var="url">
                        <c:param name="page" value="${i.index}"/>
                    </c:url>
                    <c:set value="current-page" var="current"/>
                    <c:set value="" var="perspective"/>
                    <a class="${page == i.index ? current : perspective}" href="${url}">${i.index}</a>
                </c:forEach>

                <c:url value="/" var="url">
                    <c:param name="page" value="${page + 1}"/>
                </c:url>
                <a class="${page == pagesCount ? disabled : active}" href="${url}">
                    &nbsp<span class="icon icon-next"></span>&nbsp
                </a>
                <c:url value="/" var="url">
                    <c:param name="page" value="${pagesCount}"/>
                </c:url>
                <a class="${page == pagesCount ? disabled : active}" href="${url}">
                    &nbsp<span class="icon icon-last"></span>&nbsp
                </a>
            </c:if>
            <span style="margin-left: 70px; font-size: 120%">Total number Of books: ${booksCount}</span>
        </td>
    </tr>
</table>
</body>
</html>
