<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Painel do Locador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1>Meu Catálogo Pessoal</h1>
        <div>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalCadastroObra">
                Cadastrar Nova Obra Global
            </button>
            <a href="/obras/lista" class="btn btn-secondary">Ver Catálogo Global para Adicionar</a>
        </div>
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
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal fade" id="modalCadastroObra" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Cadastrar Nova Obra no Catálogo Global</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form:form action="/obras/cadastrar" method="post" modelAttribute="obra">
                    <input type="hidden" name="originUrl" value="/locador/home">

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="isbn" class="form-label">ISBN (13 dígitos)</label>
                            <form:input path="isbn" cssClass="form-control" id="isbn" required="true"/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="titulo" class="form-label">Título</label>
                            <form:input path="titulo" cssClass="form-control" id="titulo" required="true"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="autor" class="form-label">Autor</label>
                            <form:input path="autor" cssClass="form-control" id="autor"/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="editora" class="form-label">Editora</label>
                            <form:input path="editora" cssClass="form-control" id="editora"/>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="resumoCompleto" class="form-label">Resumo</label>
                        <form:textarea path="resumoCompleto" cssClass="form-control" id="resumoCompleto" rows="3" required="true"/>
                    </div>
                    <div class="mb-3">
                        <label for="sumario" class="form-label">Sumário (Índice)</label>
                        <form:textarea path="sumario" cssClass="form-control" id="sumario" rows="3"/>
                    </div>
                    <div class="mb-3">
                        <label for="textoCompleto" class="form-label">Texto Completo (Opcional)</label>
                        <form:textarea path="textoCompleto" cssClass="form-control" id="textoCompleto" rows="5"/>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-primary">Salvar Obra</button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>