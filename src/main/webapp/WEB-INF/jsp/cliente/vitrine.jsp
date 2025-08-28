<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Vitrine de Livros</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/jsp/componentes/navbar.jsp" />

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1>Livros Disponíveis para Aluguel</h1>
    </div>

    <c:if test="${not empty successMessage}"><div class="alert alert-success">${successMessage}</div></c:if>
    <c:if test="${not empty errorMessage}"><div class="alert alert-danger">${errorMessage}</div></c:if>

    <div class="row">
        <c:choose>
            <c:when test="${not empty itensDeCatalogo}">
                <c:forEach items="${itensDeCatalogo}" var="item">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-body">
                                <h5 class="card-title">${item.obra.titulo}</h5>
                                <h6 class="card-subtitle mb-2 text-muted">${item.obra.autor}</h6>
                                <p class="card-text">${item.obra.resumoCompleto}</p>
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item"><strong>Oferecido por:</strong> ${item.locador.nome}</li>
                                <li class="list-group-item"><strong>Preço do Aluguel:</strong>
                                    <fmt:formatNumber value="${item.valorAluguel}" type="currency"/>
                                </li>
                            </ul>
                            <div class="card-body">
                                <form action="/locacoes/alugar" method="post">
                                    <input type="hidden" name="catalogoId" value="${item.id}">
                                    <button type="submit" class="btn btn-success w-100">Alugar (Sinal 50%)</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info">
                    Nenhum livro disponível para aluguel no momento.
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>