<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.example.model.News" %>

<%
    News news = (News) request.getAttribute("news");
%>

<html>
<head>
    <meta charset="UTF-8">
    <title><%= news.getTitle() %></title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="icon" type="image/png" href="favicon.png">
</head>
<body>

<div class="header">
    <div class="logo">
        <a href="home">📏 RULER NEWS</a>
    </div>

    <a>Курсова робота студентки групи ІА-43 Сивенюк Ольги</a>

        <form class="search-form" method="get" action="home">
            <input type="text" name="query" placeholder="🔍 Пошук новин..." value="${param.query}" />
            <button type="submit">Пошук</button>
        </form>
    </div>
</div>

<div style="height: 30px;"></div>

<a href="${pageContext.request.contextPath}/home" class="back-button">← Назад до новин</a>

<div style="height: 30px;"></div>

<div class="news-card">
    <h2><%= news.getTitle() %></h2>
    <p><b>Автор:</b> <%= news.getAuthor() %></p>
    <p><%= news.getContent() %></p>
    <p><i>Дата: <%= news.getCreatedAt() %></i></p>
    <p><b>Категорія:</b> <%= news.getCategory() %></p>

    <% if (news.getImageUrl() != null && !news.getImageUrl().isEmpty()) { %>
    <img src="<%= request.getContextPath() + "/" + news.getImageUrl() %>" alt="Зображення">
    <% } %>

    <div style="height: 20px;"></div>

    <c:if test="${sessionScope.role == 'user' || sessionScope.role == 'admin'}">
        <div class="vote-buttons">
            <form action="${pageContext.request.contextPath}/ratenews" method="post" style="display:inline;">
                <input type="hidden" name="newsId" value="${news.id}" />
                <button name="action" value="like">👍 Потужно ${news.likes}</button>
                <button name="action" value="dislike">👎 Не потужно ${news.dislikes}</button>
            </form>
        </div>
    </c:if>
</div>

</body>
</html>
