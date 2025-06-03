<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>RULERNEWS - сьогодні</title>
    <link rel="icon" type="image/png" href="favicon.png">
    <link rel="stylesheet" href="css/main.css">
</head>
<body>

<div class="header">
    <div class="logo">
        <a href="home">📏 RULER NEWS</a>
    </div>

    <a>Курсова робота студентки групи ІА-43 Сивенюк Ольги</a>

    <div class="header-right">
        <c:if test="${sessionScope.role == 'admin'}">
            <form method="get" action="createnews.jsp">
                <button>➕ Додати новину</button>
            </form>
        </c:if>

        <form class="search-form" method="get" action="home">
            <input type="text" name="query" placeholder="🔍 Пошук новин..." value="${param.query}" />
            <button type="submit">Пошук</button>
        </form>
    </div>
</div>

<div class="filter-block">
    <form method="get" action="home">
        <label for="category"><b>Фільтрувати за категорією:</b></label>
        <select id="category" name="category" onchange="this.form.submit()">
            <option value="all" ${param.category == 'all' ? 'selected' : ''}>Усі</option>
            <option value="Україна" ${param.category == 'Україна' ? 'selected' : ''}>Україна</option>
            <option value="Спорт" ${param.category == 'Спорт' ? 'selected' : ''}>Спорт</option>
            <option value="Ігри" ${param.category == 'Ігри' ? 'selected' : ''}>Ігри</option>
            <option value="Політика" ${param.category == 'Політика' ? 'selected' : ''}>Політика</option>
            <option value="Кулінарія" ${param.category == 'Кулінарія' ? 'selected' : ''}>Кулінарія</option>
            <option value="Мистецтво" ${param.category == 'Мистецтво' ? 'selected' : ''}>Мистецтво</option>
            <option value="Природа" ${param.category == 'Природа' ? 'selected' : ''}>Природа</option>
            <option value="Наука" ${param.category == 'Наука' ? 'selected' : ''}>Наука</option>
        </select>
    </form>
</div>

<c:forEach var="news" items="${newsList}">
    <a id="news${news.id}"></a>
    <div class="news-card">
        <h3>${news.title}</h3>
        <p><b>Автор:</b> ${news.author}</p>

        <c:choose>
            <c:when test="${fn:length(news.content) > 150}">
                <p>${fn:substring(news.content, 0, 150)}...
                    <a href="viewnews?id=${news.id}" style="color: var(--main-color); font-weight: bold;">читати далі</a>
                </p>
            </c:when>
            <c:otherwise>
                <p>${news.content}</p>
            </c:otherwise>
        </c:choose>

        <p><i>Опубліковано: ${news.createdAt}</i></p>

        <c:if test="${not empty news.imageUrl}">
            <img src="${pageContext.request.contextPath}/${news.imageUrl}" alt="Зображення" />
        </c:if>

        <p><b>Категорія:</b> ${news.category}</p>

        <c:if test="${sessionScope.role == 'user' || sessionScope.role == 'admin'}">
            <form action="${pageContext.request.contextPath}/ratenews" method="post" style="display:inline;">
                <input type="hidden" name="newsId" value="${news.id}" />
                <button name="action" value="like">👍 Потужно ${news.likes}</button>
                <button name="action" value="dislike">👎 Не потужно ${news.dislikes}</button>
            </form>
        </c:if>

        <c:if test="${sessionScope.role == 'admin'}">
            <form method="post" action="deletenews" style="display:inline;">
                <input type="hidden" name="newsId" value="${news.id}" />
                <button type="submit" onclick="return confirm('Точно видалити цю новину?')">🗑 Видалити</button>
            </form>
        </c:if>
    </div>
</c:forEach>

<div class="footer">
    <p>Цей сайт є курсовою роботою, не слід сприймати новини з цього сайту серйозно! Також ви можете запропонувати свою новину rulernews1809@gmail.com</p>
</div>

</body>
</html>
