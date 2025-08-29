<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Meu Painel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/jsp/componentes/navbar.jsp" />
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
                    <th>Valor total</th>
                    <th>Restante a pagar</th>
                    <th>Ações</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${locacoes}" var="locacao">
                    <tr>
                        <td>${locacao.itemCatalogo.obra.titulo}</td>
                        <td>${locacao.itemCatalogo.locador.nome}</td>
                        <td>${locacao.getDataLocacaoFormatada()}</td>
                        <td><fmt:formatNumber value="${locacao.getValorTotalAluguel()}" type="currency"/></td>
                        <td><fmt:formatNumber value="${locacao.getValorRestante()}" type="currency"/></td>
                        <td>
                            <button class="btn btn-sm btn-info btn-detalhes" data-locacao-id="${locacao.id}" data-bs-toggle="modal" data-bs-target="#modalDetalhesLocacao">Ver Detalhes</button>
                            <button class="btn btn-sm btn-success btn-ver-obra" data-locacao-id="${locacao.id}" data-bs-toggle="modal" data-bs-target="#modalDetalhesObra">Ver Obra</button>
                            <button class="btn btn-sm btn-warning btn-devolver" data-locacao-id="${locacao.id}">Devolver</button>
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

<div class="modal fade" id="modalDetalhesLocacao" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Detalhes da Locação</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p><strong>Locador:</strong> <span id="detalhesLocador"></span></p>
                <p><strong>Data do Aluguel:</strong> <span id="detalhesDataAluguel"></span></p>
                <p><strong>Valor Total:</strong> <span id="detalhesValorTotal"></span></p>
                <p><strong>Valor do Sinal:</strong> <span id="detalhesValorSinal"></span></p>
                <p><strong>Valor Restante:</strong> <span id="detalhesValorRestante"></span></p>
                <p><strong>Status:</strong> <span id="detalhesStatus"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalDetalhesObra" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="tituloObra"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p><strong>Autor:</strong> <span id="autorObra"></span></p>
                <p><strong>Editora:</strong> <span id="editoraObra"></span></p>
                <p><strong>ISBN:</strong> <span id="isbnObra"></span></p>
                <hr>
                <h4>Resumo Completo</h4>
                <p id="resumoObra"></p>
                <hr>
                <h4>Sumário</h4>
                <p id="sumarioObra"></p>
                <hr>
                <h4>Texto Completo</h4>
                <p id="textoCompletoObra"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Inicialização e cache para os modais
        const modalDetalhesLocacao = new bootstrap.Modal(document.getElementById('modalDetalhesLocacao'));
        const modalDetalhesObra = new bootstrap.Modal(document.getElementById('modalDetalhesObra'));
        const locacoesCache = {};

        // 1. Lógica para botões de Detalhes e Obra
        document.querySelectorAll('.btn-detalhes, .btn-ver-obra').forEach(button => {
            button.addEventListener('click', function() {
                const locacaoId = this.getAttribute('data-locacao-id');
                const isDetalhesBtn = this.classList.contains('btn-detalhes');

                if (locacoesCache[locacaoId]) {
                    fillModals(locacoesCache[locacaoId], isDetalhesBtn);
                } else {
                    fetch('/cliente/locacao/' + locacaoId + '/detalhes')
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Locação não encontrada ou acesso negado.');
                            }
                            return response.json();
                        })
                        .then(locacao => {
                            locacoesCache[locacaoId] = locacao;
                            fillModals(locacao, isDetalhesBtn);
                        })
                        .catch(error => {
                            console.error('Erro ao buscar detalhes:', error);
                            alert('Não foi possível carregar os detalhes do livro.');
                        });
                }
            });
        });

        // 2. Lógica para o botão de Devolução
        document.querySelectorAll('.btn-devolver').forEach(button => {
            button.addEventListener('click', function() {
                const locacaoId = this.getAttribute('data-locacao-id');
                const confirmacao = confirm("Tem certeza que deseja devolver este livro?");

                if (confirmacao) {
                    fetch('/cliente/devolver/' + locacaoId, {
                        method: 'POST'
                    })
                    .then(response => {
                        if (response.ok) {
                            alert('Livro devolvido com sucesso!');
                            window.location.reload();
                        } else {
                            return response.text().then(errorMessage => {
                                throw new Error(errorMessage);
                            });
                        }
                    })
                    .catch(error => {
                        console.error('Erro na devolução:', error);
                        alert('Erro na devolução: ' + error.message);
                    });
                }
            });
        });

        // Funções auxiliares
        function fillModals(locacao, isDetalhesBtn) {
            document.getElementById('detalhesLocador').textContent = locacao.itemCatalogo.locador.nome;
            document.getElementById('detalhesDataAluguel').textContent = locacao.dataLocacaoFormatada;
            document.getElementById('detalhesValorTotal').textContent = formatCurrency(locacao.valorTotalAluguel);
            document.getElementById('detalhesValorSinal').textContent = formatCurrency(locacao.valorSinal);
            document.getElementById('detalhesValorRestante').textContent = formatCurrency(locacao.valorRestante);
            document.getElementById('detalhesStatus').textContent = locacao.status;

            document.getElementById('tituloObra').textContent = locacao.itemCatalogo.obra.titulo;
            document.getElementById('autorObra').textContent = locacao.itemCatalogo.obra.autor;
            document.getElementById('editoraObra').textContent = locacao.itemCatalogo.obra.editora;
            document.getElementById('isbnObra').textContent = locacao.itemCatalogo.obra.isbn;
            document.getElementById('resumoObra').textContent = locacao.itemCatalogo.obra.resumoCompleto;
            document.getElementById('sumarioObra').textContent = locacao.itemCatalogo.obra.sumario;
            document.getElementById('textoCompletoObra').textContent = locacao.itemCatalogo.obra.textoCompleto;

            if (isDetalhesBtn) {
                modalDetalhesLocacao.show();
            } else {
                modalDetalhesObra.show();
            }
        }

        function formatCurrency(value) {
            return new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(value);
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>