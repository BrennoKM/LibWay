<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Painel do Locações</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/jsp/componentes/navbar.jsp" />
<div class="container mt-5">
    <h2>Painel de Locações</h2>
    <hr>

    <h4>Locações Ativas</h4>
    <c:choose>
        <c:when test="${not empty locacoesAtivas}">
            <table class="table table-hover table-bordered">
                <thead>
                    <tr>
                        <th>Livro</th>
                        <th>Cliente</th>
                        <th>Data do Aluguel</th>
                        <th>Valor do Sinal</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${locacoesAtivas}" var="locacao">
                        <tr>
                            <td>${locacao.itemCatalogo.obra.titulo}</td>
                            <td>${locacao.cliente.nome}</td>
                            <td>${locacao.getDataLocacaoFormatada()}</td>
                            <td><fmt:formatNumber value="${locacao.valorSinal}" type="currency"/></td> <!-- Exibe o valor do sinal -->
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info">
                Você não possui locações ativas no momento.
            </div>
        </c:otherwise>
    </c:choose>

    <hr>

    <h4>Locações Finalizadas</h4>
    <c:choose>
        <c:when test="${not empty locacoesFinalizadas}">
            <table class="table table-hover table-bordered">
                <thead>
                    <tr>
                        <th>Livro</th>
                        <th>Cliente</th>
                        <th>Data do Aluguel</th>
                        <th>Data da Devolução</th>
                        <th>Valor Faturado</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${locacoesFinalizadas}" var="locacao">
                        <tr>
                            <td>${locacao.itemCatalogo.obra.titulo}</td>
                            <td>${locacao.cliente.nome}</td>
                            <td>${locacao.getDataLocacaoFormatada()}</td>
                            <td>${locacao.getDataDevolucaoFormatada()}</td>
                            <td><fmt:formatNumber value="${locacao.getValorTotalAluguel()}" type="currency"/></td> <!-- Exibe o valor total do aluguel -->
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info">
                Você não possui locações finalizadas no momento.
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>