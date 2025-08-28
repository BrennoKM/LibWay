<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="/">LibWay</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <sec:authorize access="isAuthenticated()">
                    <li class="nav-item">
                        <a class="nav-link" href="/">Home</a>
                    </li>
                </sec:authorize>

                <sec:authorize access="hasRole('LOCADOR')">
                    <li class="nav-item">
                        <a class="nav-link" href="/obras/lista">Catálogo Global</a>
                    </li>
                </sec:authorize>

                <sec:authorize access="hasRole('CLIENTE')">
                    <li class="nav-item">
                        <a class="nav-link" href="#">Ver Vitrine</a>
                    </li>
                </sec:authorize>
            </ul>

            <sec:authorize access="isAuthenticated()">
                <form action="/logout" method="post" class="d-flex">
                    <span class="navbar-text me-3">
                        Olá, <sec:authentication property="principal.username"/>
                    </span>
                    <button class="btn btn-outline-light" type="submit">Sair</button>
                </form>
            </sec:authorize>
        </div>
    </div>
</nav>