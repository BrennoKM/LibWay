<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Registro de Novo Usuário</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3>Crie sua Conta</h3>
                </div>
                <div class="card-body">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">
                            ${errorMessage}
                        </div>
                    </c:if>
                    <c:if test="${param.error != null}">
                        <div class="alert alert-danger">
                            Email ou senha inválidos.
                        </div>
                    </c:if>
                    <form:form action="/registrar" method="post" modelAttribute="usuario">

                        <div class="mb-3">
                            <label for="nome" class="form-label">Nome Completo</label>
                            <form:input path="nome" cssClass="form-control" id="nome" required="true"/>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <form:input path="email" type="email" cssClass="form-control" id="email" required="true"/>
                        </div>

                        <div class="mb-3">
                            <label for="senha" class="form-label">Senha</label>
                            <form:password path="senha" cssClass="form-control" id="senha" required="true"/>
                        </div>

                        <div class="mb-3">
                            <label for="tipoUsuario" class="form-label">Eu sou</label>
                            <form:select path="tipoUsuario" cssClass="form-select" id="tipoUsuario">
                                <form:option value="CLIENTE">Cliente (Quero alugar livros)</form:option>
                                <form:option value="LOCADOR">Locador (Tenho livros para alugar)</form:option>
                            </form:select>
                        </div>

                        <div id="campoCpf" class="mb-3">
                            <label for="cpf" class="form-label">CPF</label>
                            <form:input path="cpf" cssClass="form-control" id="cpf" required="true"/>
                        </div>

                        <div id="campoCnpj" class="mb-3" style="display: none;">
                            <label for="cnpj" class="form-label">CNPJ</label>
                            <form:input path="cnpj" cssClass="form-control" id="cnpj" required="true"/>
                        </div>

                        <button type="submit" class="btn btn-primary w-100">Registrar</button>

                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const tipoUsuarioSelect = document.getElementById('tipoUsuario');
    const campoCpf = document.getElementById('campoCpf');
    const campoCnpj = document.getElementById('campoCnpj');

    const inputCpf = document.getElementById('cpf');
    const inputCnpj = document.getElementById('cnpj');

    tipoUsuarioSelect.addEventListener('change', function() {
        if (this.value === 'CLIENTE') {
            campoCpf.style.display = 'block';
            inputCpf.disabled = false;

            campoCnpj.style.display = 'none';
            inputCnpj.disabled = true;
        } else if (this.value === 'LOCADOR') {
            campoCpf.style.display = 'none';
            inputCpf.disabled = true;

            campoCnpj.style.display = 'block';
            inputCnpj.disabled = false;
        }
    });

    inputCnpj.disabled = true;
</script>

</body>
</html>