<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Histórico de Depósitos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/jsp/componentes/navbar.jsp" />
<div class="container mt-5">
    <h2>Histórico de Depósitos</h2>
    <hr>
    <c:choose>
        <c:when test="${not empty depositos}">
            <table class="table table-hover table-bordered">
                <thead>
                    <tr>
                        <th>Valor</th>
                        <th>Método de Pagamento</th>
                        <th>Data do Depósito</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${depositos}" var="deposito">
                        <tr>
                            <td><fmt:formatNumber value="${deposito.valor}" type="currency"/></td>
                            <td>${deposito.metodoPagamento}</td>
                            <td>${deposito.getDataDepositoFormatada()}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info">
                Você ainda não possui depósitos em seu histórico.
            </div>
        </c:otherwise>
    </c:choose>
    <a href="/cliente/home" class="btn btn-secondary mt-3">Voltar</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>