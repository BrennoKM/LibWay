<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Página Principal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="alert alert-success">
            <h1>Login bem-sucedido!</h1>
            <p>Bem-vindo à área segura da aplicação.</p>
        </div>

        <form action="/logout" method="post">
            <button type="submit" class="btn btn-danger">Sair</button>
        </form>
    </div>
</body>
</html>