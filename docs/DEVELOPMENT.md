# Desenvolvimento do Apollo Shell

## Requisitos

- Linux com Wayland.
- Hyprland para os testes de integração futuros.
- Quickshell 0.3 ou superior.
- Bash 5 ou superior.
- Python 3 para as verificações estáticas do projeto.

## Preparação do editor

O Quickshell recomenda que o arquivo `.qmlls.ini` seja criado localmente ao lado de `shell.qml`. O conteúdo é específico de cada computador e, por isso, o arquivo está no `.gitignore`.

```bash
touch .qmlls.ini
```

O Quickshell preencherá o arquivo quando necessário para integrar o projeto ao `qmlls`.

## Executar em modo de desenvolvimento

```bash
./scripts/run-dev.sh
```

Argumentos adicionais são encaminhados ao comando `qs`:

```bash
./scripts/run-dev.sh --verbose
```

O Quickshell mantém o recarregamento de arquivos habilitado por padrão. Esse comportamento é controlado centralmente por `Config.hotReloadEnabled`.

## Validar a fundação

A verificação estática não exige uma sessão gráfica:

```bash
./scripts/check-foundation.sh
```

Ela confirma:

- presença dos arquivos obrigatórios;
- validade de `config/defaults.json`;
- sintaxe dos scripts Bash;
- balanceamento básico de delimitadores nos arquivos QML.

Para realizar também um teste curto de execução dentro de uma sessão Wayland:

```bash
APOLLO_RUNTIME_CHECK=1 ./scripts/check-foundation.sh
```

O teste abre o shell por alguns segundos e considera o encerramento pelo comando `timeout` como esperado. A duração pode ser alterada:

```bash
APOLLO_RUNTIME_CHECK=1 APOLLO_RUNTIME_TIMEOUT=10 ./scripts/check-foundation.sh
```

## Configuração central

`config/Config.qml` é a única interface pública de configuração nesta etapa. O singleton carrega `config/defaults.json` por meio de `FileView` e `JsonAdapter`.

Módulos visuais não devem abrir ou interpretar o JSON diretamente. Eles devem consumir propriedades como:

```qml
AppConfig.Config.darkMode
AppConfig.Config.animationsEnabled
AppConfig.Config.effectiveScale
AppConfig.Config.showBootstrapSurface
```

A variável de ambiente `APOLLO_DEBUG=1` habilita logs de depuração sem modificar o arquivo padrão.

## Logging

Todos os logs internos devem passar pelo singleton `core/Logger.qml`:

```qml
Core.Logger.info(Core.Constants.shellCategory, "Mensagem")
Core.Logger.warning(Core.Constants.audioCategory, "Serviço indisponível")
Core.Logger.error(Core.Constants.hyprlandCategory, "Falha de IPC", {
    error: errorMessage
})
```

Formato produzido:

```text
[APOLLO][SHELL][INFO] Apollo Shell runtime initialized
```

Não use `console.log`, `console.warn` ou `console.error` diretamente fora do logger, exceto durante uma investigação temporária.

## Superfície de diagnóstico

Durante o Marco 1, uma pequena superfície é criada no canto superior esquerdo de cada monitor. Ela existe apenas para provar que:

- os monitores são detectados dinamicamente;
- superfícies transparentes funcionam;
- configuração e escala são reativas;
- temas claro e escuro chegam aos módulos;
- o runtime e o logger foram inicializados.

Ela será substituída pelos módulos reais nos marcos seguintes e não representa um widget definitivo do desktop.

## Organização

- `core/`: runtime, constantes, caminhos e logging.
- `config/`: configuração central e valores padrão.
- `theme/`: tokens visuais, a partir do Marco 2.
- `components/`: componentes visuais reutilizáveis, a partir do Marco 3.
- `services/`: integrações do sistema.
- `models/`: modelos normalizados para a interface.
- `modules/`: superfícies e funcionalidades de alto nível.
- `assets/`: ícones, ilustrações e wallpapers próprios.
- `scripts/`: execução, validação e instalação.
