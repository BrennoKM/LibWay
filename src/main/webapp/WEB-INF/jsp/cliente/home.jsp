<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Meu Painel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2>Olá, ${cliente.nome}!</h2>
            <h4>Seu Saldo:
                <span class="badge bg-success">
                    <fmt:formatNumber value="${cliente.saldo}" type="currency"/>
                </span>
            </h4>
        </div>
        <div>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAdicionarSaldo">
                Adicionar Saldo
            </button>
        </div>
    </div>

    <hr>

    <h4>Meus Aluguéis Ativos</h4>
    <c:choose>
        <c:when test="${not empty locacoes}">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>Livro</th>
                    <th>Locador</th>
                    <th>Data do Aluguel</th>
                    <th>Ações</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${locacoes}" var="locacao">
                    <tr>
                        <td>${locacao.itemCatalogo.obra.titulo}</td>
                        <td>${locacao.itemCatalogo.locador.nome}</td>
                        <td><fmt:formatDate value="${locacao.dataLocacao.toLocalDate()}" pattern="dd/MM/yyyy"/></td>
                        <td>
                            <button class="btn btn-sm btn-info">Ver Detalhes</button>
                            <button class="btn btn-sm btn-warning">Devolver</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info">
                Você não possui aluguéis ativos no momento.
            </div>
        </c:otherwise>
    </c:choose>
</div>

<div class="modal fade" id="modalAdicionarSaldo" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Adicionar Saldo à Conta</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="/cliente/saldo/adicionar" method="post">
                    <div class="mb-3">
                        <label for="valor" class="form-label">Valor a adicionar (R$)</label>
                        <input type="number" name="valor" class="form-control" required step="0.01" min="1">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Método de Pagamento</label>
                        <select name="metodoPagamento" class="form-select">
                            <option value="PIX">PIX</option>
                            <option value="CARTAO">Cartão de Crédito</option>
                            <option value="BOLETO">Boleto</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Adicionar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>