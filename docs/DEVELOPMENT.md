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

## Executar em modo de desenvolvimento

```bash
./scripts/run-dev.sh
```

Argumentos adicionais são encaminhados ao comando `qs`:

```bash
./scripts/run-dev.sh --verbose
```

O script adiciona `data/` ao `XDG_DATA_DIRS` apenas para o processo do Apollo. Isso permite que o portal localize `io.github.maylton.apollo-shell.desktop` sem instalar arquivos no sistema e sem alterar o Caelestia.

O recarregamento de arquivos fica habilitado por padrão e é controlado por `Config.hotReloadEnabled`.

## Validar

A verificação estática não exige uma sessão gráfica:

```bash
./scripts/check-foundation.sh
```

Ela confirma:

- presença dos arquivos obrigatórios;
- validade de `config/defaults.json`;
- sintaxe dos scripts Bash e Python;
- balanceamento básico de delimitadores QML;
- registro dos singletons visuais;
- presença dos tokens semânticos mínimos;
- ausência de cores hexadecimais nos módulos de demonstração;
- consumo compartilhado de cor, tipografia, formas e espaçamento.

Para realizar também um teste curto dentro de uma sessão Wayland:

```bash
APOLLO_RUNTIME_CHECK=1 ./scripts/check-foundation.sh
```

A duração pode ser alterada:

```bash
APOLLO_RUNTIME_CHECK=1 APOLLO_RUNTIME_TIMEOUT=10 ./scripts/check-foundation.sh
```

## Configuração central

`config/Config.qml` continua sendo a única interface pública de configuração. Módulos não devem abrir ou interpretar `defaults.json` diretamente.

```qml
AppConfig.Config.darkMode
AppConfig.Config.animationsEnabled
AppConfig.Config.effectiveScale
AppConfig.Config.showBootstrapSurface
```

A variável `APOLLO_DEBUG=1` habilita logs de depuração sem modificar o arquivo padrão.

## Sistema visual

Os tokens ficam isolados em `theme/`:

```text
theme/
├── Colors.qml
├── Typography.qml
├── Shapes.qml
├── Spacing.qml
├── Elevation.qml
├── Motion.qml
├── Theme.qml
└── qmldir
```

`Theme.qml` é o ponto de entrada. Componentes visuais devem importar o diretório e consumir os grupos compartilhados:

```qml
import "../../theme" as Tokens

Rectangle {
    radius: Tokens.Theme.shapes.extraLarge
    color: Tokens.Theme.colors.surfaceContainer
}
```

Para medidas que precisam acompanhar `interfaceScale`, use:

```qml
width: Tokens.Theme.scaled(48)
duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.normal)
```

Não replique cores, raios, espaçamentos, pesos tipográficos ou durações nos módulos. Um valor visual novo deve primeiro receber um papel semântico no sistema de tokens.

## Tema claro e escuro

As propriedades de `Colors.qml` reagem a `Config.darkMode`. Durante esta fase, a troca pode ser testada alterando `config/defaults.json` enquanto o Apollo está em execução:

```json
{
  "darkMode": true
}
```

O `FileView` recarrega o arquivo e as ligações QML atualizam a interface sem recriar os componentes. Controles futuros poderão chamar:

```qml
Tokens.Theme.toggleDarkMode()
```

## Tipografia

Os papéis tipográficos expõem família, tamanho, peso, espaçamento entre letras e altura de linha. O Apollo prefere `Roboto Flex` para títulos expressivos e `Roboto` para textos. O Qt utiliza fallback quando essas fontes não estão instaladas.

Exemplo:

```qml
Text {
    font.family: Tokens.Theme.typography.titleLarge.family
    font.pixelSize: Tokens.Theme.scaled(
        Tokens.Theme.typography.titleLarge.pixelSize
    )
    font.weight: Tokens.Theme.typography.titleLarge.weight
}
```

## Logging

Todos os logs internos devem passar por `core/Logger.qml`:

```qml
Core.Logger.info(Core.Constants.themeCategory, "Color scheme changed", {
    mode: Tokens.Theme.modeName
})
```

Formato produzido:

```text
[APOLLO][THEME][INFO] Color scheme changed
```

## Galeria temporária

`modules/bootstrap/ThemePreview.qml` demonstra os tokens em uma superfície sem zona exclusiva, sem foco e sem substituir elementos do Caelestia. Ela não representa um widget definitivo do desktop.

A galeria será removida quando os componentes reutilizáveis do Marco 3 assumirem a validação visual.

## Organização

- `core/`: runtime, constantes, caminhos e logging.
- `config/`: configuração central e valores padrão.
- `theme/`: tokens visuais e coordenação de tema.
- `components/`: componentes reutilizáveis, a partir do Marco 3.
- `services/`: integrações do sistema.
- `models/`: modelos normalizados para a interface.
- `modules/`: superfícies e funcionalidades de alto nível.
- `assets/`: ícones, ilustrações e wallpapers próprios.
- `data/`: metadados de integração local.
- `scripts/`: execução e validação.
