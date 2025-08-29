<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Painel do Locador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/jsp/componentes/navbar.jsp" />
<div class="container mt-5">
    <div>
        <h4>Faturamento Atual:
            <span class="badge bg-success">
                <fmt:formatNumber value="${locador.saldo}" type="currency"/>
            </span>
        </h4>
    </div>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1>Meu Catálogo Pessoal</h1>
    </div>

    <div class="card">
        <div class="card-header">
            Meus Livros para Aluguel
        </div>
        <div class="card-body">
            <table class="table table-hover">
                <thead class="table-light">
                <tr>
                    <th>Título</th>
                    <th>ISBN</th>
                    <th>Meu Estoque</th>
                    <th>Meu Preço de Aluguel</th>
                    <th>Ações</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${catalogoPessoal}" var="item">
                    <tr>
                        <td>${item.obra.titulo}</td>
                        <td>${item.obra.isbn}</td>
                        <td>${item.estoque}</td>
                        <td>
                            <fmt:setLocale value="pt_BR"/>
                            <fmt:formatNumber value="${item.valorAluguel}" type="currency"/>
                        </td>
                        <td>
                            <button type="button" class="btn btn-sm btn-primary btn-editar-catalogo"
                                    data-bs-toggle="modal"
                                    data-bs-target="#modalEditarCatalogo"
                                    data-id="${item.id}"
                                    data-estoque="${item.estoque}"
                                    data-valor-aluguel="${item.valorAluguel}">
                                Editar
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal fade" id="modalEditarCatalogo" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Editar Item do Catálogo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="formEditarCatalogo" action="/locador/catalogo/alterar" method="post">
                    <input type="hidden" id="itemId" name="id">
                    <div class="mb-3">
                        <label for="inputEstoque" class="form-label">Estoque</label>
                        <input type="number" class="form-control" id="inputEstoque" name="estoque" required min="0">
                    </div>
                    <div class="mb-3">
                        <label for="inputValorAluguel" class="form-label">Preço de Aluguel (R$)</label>
                        <input type="number" class="form-control" id="inputValorAluguel" name="valorAluguel" required step="0.01" min="0">
                    </div>
                    <button type="submit" class="btn btn-primary">Salvar Alterações</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const modalEditarCatalogo = document.getElementById('modalEditarCatalogo');
        modalEditarCatalogo.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            const id = button.getAttribute('data-id');
            const estoque = button.getAttribute('data-estoque');
            const valorAluguel = button.getAttribute('data-valor-aluguel');

            const modalBody = modalEditarCatalogo.querySelector('.modal-body');
            modalBody.querySelector('#itemId').value = id;
            modalBody.querySelector('#inputEstoque').value = estoque;
            modalBody.querySelector('#inputValorAluguel').value = valorAluguel;
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>