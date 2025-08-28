<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Nova Obra</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h3>Cadastrar Nova Obra no Catálogo Global</h3>
                </div>
                <div class="card-body">

                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success">
                            ${successMessage}
                        </div>
                    </c:if>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">
                            ${errorMessage}
                        </div>
                    </c:if>

                    <form:form action="/obras/cadastrar" method="post" modelAttribute="obra">
                        <div class="mb-3">
                            <label for="isbn" class="form-label">ISBN (13 dígitos)</label>
                            <%-- path="isbn": Conecta ao atributo 'isbn' da classe Obra --%>
                            <form:input path="isbn" cssClass="form-control" id="isbn" required="true"/>
                        </div>

                        <div class="mb-3">
                            <label for="titulo" class="form-label">Título</label>
                            <form:input path="titulo" cssClass="form-control" id="titulo" required="true"/>
                        </div>

                        <div class="mb-3">
                            <label for="autor" class="form-label">Autor</label>
                            <form:input path="autor" cssClass="form-control" id="autor"/>
                        </div>

                        <div class="mb-3">
                            <label for="editora" class="form-label">Editora</label>
                            <form:input path="editora" cssClass="form-control" id="editora"/>
                        </div>

                        <div class="mb-3">
                            <label for="resumoCompleto" class="form-label">Resumo</label>
                            <%-- path="resumoCompleto": Note como o camelCase do Java é usado aqui. --%>
                            <form:textarea path="resumoCompleto" cssClass="form-control" id="resumoCompleto" rows="4" required="true"/>
                        </div>

                        <div class="mb-3">
                            <label for="sumario" class="form-label">Sumário (Índice)</label>
                            <form:textarea path="sumario" cssClass="form-control" id="sumario" rows="4"/>
                        </div>

                         <div class="mb-3">
                            <label for="textoCompleto" class="form-label">Texto Completo (Opcional)</label>
                            <form:textarea path="textoCompleto" cssClass="form-control" id="textoCompleto" rows="6"/>
                        </div>

                        <button type="submit" class="btn btn-primary">Salvar Obra</button>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>