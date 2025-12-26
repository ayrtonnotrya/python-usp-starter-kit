# Python USP Starter Kit 🇧🇷

**A base oficial para desenvolvimento web e ciência de dados na Universidade de São Paulo.**

## 1. Visão Geral

O **Python USP Starter Kit** é a tradução da excelência do ecossistema *Laravel USP* para o mundo Python. Criado para atender à crescente demanda por aplicações de Inteligência Artificial e Análise de Dados na universidade, este kit oferece uma estrutura "batteries-included" que elimina semanas de configuração inicial.

Diferente de um projeto Django comum, ele já nasce integrado à infraestrutura corporativa da USP (Senha Única e Base Replicada), seguindo rigorosamente os padrões de segurança da STI e as melhores práticas de Engenharia de Software (Twelve-Factor App).

**Por que usar este kit?**
*   🚀 **Zero Config:** Autenticação OAuth e conexões de banco legados (Sybase) pré-configuradas.
*   🤖 **AI-Ready:** Estrutura otimizada para desenvolvimento com Agentes Autônomos (Google Antigravity/Cursor).
*   🔒 **Seguro por Padrão:** Containerização *hardened* e gestão segura de segredos.

---

## 2. Principais Funcionalidades

*   **Autenticação Híbrida:**
    *   Backend primário via **Senha Única USP (OAuth 1.0a)** utilizando `senhaunica-socialite-python`.
    *   Sistema de permissões (Admin/Manager/User) integrado ao Django Admin.
    *   *Login-as* (impersonate) para suporte e debug.
*   **Integração com Replicado:**
    *   Camada de dados híbrida: **SQLAlchemy 2.0** para consultas de alta performance no Sybase/MSSQL e **Django ORM** para dados locais.
    *   Models pré-mapeados para tabelas comuns (Pessoa, Graduação, Pós).
*   **Infraestrutura de Background:**
    *   **Celery + Redis** configurados para filas de tarefas assíncronas (envio de e-mails, processamento de dados).
*   **Monitoramento e Logs:**
    *   Logging estruturado pronto para ingestão (Graylog/Elastic).
    *   Auditoria automática de ações de usuários.

---

## 3. Guia de Instalação

### Pré-requisitos
*   Docker & Docker Compose
*   Poetry 1.8+

### Passo a Passo

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/ayrtonnotrya/python-usp-starter-kit.git meu-projeto
    cd meu-projeto
    ```

2.  **Instale as dependências (Local):**
    ```bash
    poetry install
    ```

3.  **Suba a infraestrutura:**
    ```bash
    # Inicia Banco (Postgres), Redis e a Aplicação Web
    docker-compose up -d --build
    ```

4.  **Execute as migrações iniciais:**
    ```bash
    docker-compose exec web python manage.py migrate
    ```

Acesse em: `http://localhost:8000`

---

## 4. Configuração do Ambiente (.env)

Copie o arquivo de exemplo: `cp .env.example .env`.
Abaixo estão as variáveis críticas que conectam sua aplicação ao ecossistema da USP.

| Categoria | Variável | Descrição |
| :--- | :--- | :--- |
| **Geral** | `DJANGO_ENV` | `development` ou `production`. |
| | `SECRET_KEY` | Chave criptográfica do Django. |
| **Senha Única** | `SENHAUNICA_KEY` | *Consumer Key* fornecida pela STI. |
| | `SENHAUNICA_SECRET` | *Consumer Secret* fornecida pela STI. |
| | `SENHAUNICA_CALLBACK_URL` | Ex: `http://localhost:8000/callback`. |
| **Replicado** | `REPLICADO_HOST` | IP do servidor da réplica local. |
| | `REPLICADO_PORT` | Porta (padrão `5000` Sybase ou `1433` MSSQL). |
| | `REPLICADO_DATABASE` | Nome do banco (ex: `replicacao`). |
| | `REPLICADO_USERNAME` | Usuário de leitura. |
| | `REPLICADO_PASSWORD` | Senha do banco. |
| | `REPLICADO_SYBASE` | `True` para forçar compatibilidade com drivers legados. |

---

## 5. Desenvolvimento Agent-First (Google Antigravity)

Este projeto adota a filosofia **Agent-First**. Se você utiliza o **Google Antigravity IDE** ou editores baseados em IA, o diretório `.agent/` funciona como o "Mission Control".

### Regras para Agentes (`.agent/rules`)
O arquivo `.agent/rules/python_usp.md` contém diretrizes estritas que garantem que o código gerado por IA siga nossos padrões.

*   **Regra de Ouro:** Agentes nunca devem usar SQL puro sem `sqlalchemy.text()` e *bind parameters*.
*   **Tipagem:** Todo código novo deve passar na validação estrita do `mypy`.
*   **Padrão de Camadas:** A lógica de negócio deve residir em `services/`, nunca nas `views`.

**Exemplo de Prompt para o Agente:**
> "Utilizando as regras do projeto, crie um Service que busque o histórico escolar de um aluno no Replicado e salve um resumo em cache Redis."

---

## 6. Segurança (SSDLC)

A segurança não é opcional na USP. O kit implementa:

1.  **Docker Hardening:**
    *   Usuário não-root (`appuser`) no container de produção.
    *   Imagem base `python:3.14-slim-bookworm` para reduzir superfície de ataque.
2.  **Proteção Web:**
    *   Middlewares de segurança do Django ativados (`SECURE_SSL_REDIRECT`, `CSRF_COOKIE_SECURE` em prod).
    *   Sanitização automática de inputs do Replicado para evitar *SQL Injection* em bancos legados.
3.  **Gestão de Segredos:**
    *   O `docker-compose.yml` nunca expõe portas de banco de dados para a rede externa em produção.

---

## 7. Testes e Qualidade

Mantemos a qualidade do código alta para garantir a manutenibilidade a longo prazo.

**Rodar Testes Unitários e de Integração:**
```bash
# Roda a suíte completa com relatório de cobertura
poetry run pytest --cov=apps
```

**Verificação de Estilo e Tipagem (Linting):**
```bash
# Verifica PEP 8 e bugs potenciais
poetry run ruff check .

# Verifica consistência de tipos
poetry run mypy .
```