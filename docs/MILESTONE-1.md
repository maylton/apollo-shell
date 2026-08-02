# Marco 1 — Fundação do projeto

Status: **implementado na branch `feat/milestone-1-foundation`**.

## Entregas

- [x] Estrutura inicial modular do repositório.
- [x] Entrypoint `shell.qml` com `ShellRoot`.
- [x] Instância de superfície para cada monitor conectado por meio de `Variants`.
- [x] Superfície transparente de diagnóstico.
- [x] Singleton central `Apollo` para inicialização do runtime.
- [x] Singleton `Constants` para metadados e medidas temporárias.
- [x] Singleton `Paths` para caminhos do shell, estado, cache e dados.
- [x] Singleton `Config` como única interface pública de configuração.
- [x] Carregamento central de `defaults.json` com `FileView` e `JsonAdapter`.
- [x] Suporte à variável `APOLLO_DEBUG`.
- [x] Logger estruturado e categorizado.
- [x] Logs de inicialização, recarregamento e criação de superfícies.
- [x] Script de execução em desenvolvimento.
- [x] Script de validação estática e teste opcional de runtime.
- [x] Pipeline básico de validação para pull requests.
- [x] Documentação de desenvolvimento.

## Critério de conclusão

O Marco 1 é considerado concluído quando o projeto:

1. passa em `./scripts/check-foundation.sh`;
2. inicia com `./scripts/run-dev.sh` em uma sessão Wayland com Quickshell 0.3+;
3. cria uma superfície de diagnóstico em cada monitor;
4. apresenta logs no formato `[APOLLO][CATEGORIA][NÍVEL]`;
5. reage ao tema, escala e visibilidade definidos em `config/defaults.json`;
6. recarrega durante o desenvolvimento sem espalhar estado ou configuração pelos módulos.

## Validação manual

```bash
./scripts/check-foundation.sh
APOLLO_DEBUG=1 APOLLO_RUNTIME_CHECK=1 ./scripts/check-foundation.sh
```

Saída visual esperada: um pequeno cartão arredondado no canto superior esquerdo de cada monitor, exibindo o nome e a versão do Apollo Shell e o nome do monitor detectado.

Esse cartão é temporário e será removido quando as superfícies definitivas começarem a ser implementadas.

## Próxima etapa

O Marco 2 implementará os tokens compartilhados de cor, tipografia, formas, espaçamento, elevação e movimento. A superfície de diagnóstico será migrada para consumir exclusivamente esses tokens.
