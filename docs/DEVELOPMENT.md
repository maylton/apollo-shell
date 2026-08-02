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
- registro de todos os componentes em seus respectivos `qmldir`;
- ausência de cores hexadecimais fora do sistema visual;
- independência dos componentes em relação a módulos e serviços;
- imports obrigatórios para `MouseArea`, `Layout.*`, `Connections` e `QtObject`;
- instanciação de todas as primitivas na galeria interna.

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

`Theme.qml` é o ponto de entrada:

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

## Biblioteca de componentes

As primitivas ficam organizadas por responsabilidade:

```text
components/
├── surfaces/
│   ├── ApolloSurface.qml
│   ├── ApolloCard.qml
│   ├── ApolloPanel.qml
│   ├── ApolloPopup.qml
│   └── ApolloScrim.qml
├── buttons/
│   ├── ApolloButton.qml
│   ├── ApolloIconButton.qml
│   ├── ApolloPillButton.qml
│   └── ApolloAppButton.qml
├── controls/
│   ├── ApolloToggle.qml
│   ├── ApolloSlider.qml
│   ├── ApolloProgress.qml
│   └── ApolloSegmentedControl.qml
├── layout/
│   ├── ApolloRow.qml
│   ├── ApolloColumn.qml
│   ├── ApolloGrid.qml
│   ├── ApolloSection.qml
│   └── ApolloSpacer.qml
└── feedback/
    ├── ApolloTooltip.qml
    ├── ApolloRipple.qml
    ├── ApolloLoadingIndicator.qml
    └── ApolloEmptyState.qml
```

Os módulos devem compor essas primitivas em vez de criar novos retângulos e interações para cada tela:

```qml
import "../../components/surfaces" as Surfaces
import "../../components/buttons" as Buttons
import "../../components/layout" as ApolloLayout

Surfaces.ApolloCard {
    ApolloLayout.ApolloRow {
        anchors.fill: parent

        Buttons.ApolloPillButton {
            text: "Open"
        }
    }
}
```

### Limites de dependência

Componentes podem depender de:

- QtQuick e QtQuick.Layouts;
- `theme/`;
- componentes de uma camada primitiva equivalente.

Componentes não devem importar:

- `modules/`;
- `services/`;
- `models/`;
- arquivos de configuração diretamente.

Essa direção de dependência permite que dock, launcher, dashboard e central de controle reutilizem a mesma implementação sem ciclos.

### Conteúdo de superfícies

`ApolloSurface` expõe uma propriedade padrão para conteúdo. `ApolloCard`, `ApolloPanel` e `ApolloPopup` herdam esse comportamento:

```qml
Surfaces.ApolloCard {
    Text {
        anchors.centerIn: parent
        text: "Reusable content"
    }
}
```

### Estados de interação

Botões e controles devem oferecer estados coerentes para:

- normal;
- hover;
- pressed;
- active ou checked;
- disabled.

Novos estados visuais devem usar os papéis de estado definidos em `Colors.qml`.

## Tema claro e escuro

As propriedades de `Colors.qml` reagem a `Config.darkMode`. A galeria permite alternar o tema pelo botão no cabeçalho ou por edição de `config/defaults.json`.

```qml
Tokens.Theme.toggleDarkMode()
```

## Tipografia

Os papéis tipográficos expõem família, tamanho, peso, espaçamento entre letras e altura de linha. O Apollo prefere `Roboto Flex` para títulos expressivos e `Roboto` para textos. O Qt utiliza fallback quando essas fontes não estão instaladas.

## Logging

Todos os logs internos devem passar por `core/Logger.qml`:

```qml
Core.Logger.info(Core.Constants.componentsCategory, "Component gallery ready")
```

Formato produzido:

```text
[APOLLO][COMPONENTS][INFO] Component gallery ready
```

## Galeria temporária

`modules/bootstrap/ThemePreview.qml` agora é uma galeria interativa que instancia todas as primitivas. Ela permite verificar:

- composição das superfícies;
- estados de botões;
- toggle, slider, progresso e controle segmentado;
- comportamento de layouts;
- loading, tooltip, ripple e empty state;
- transição entre tema claro e escuro.

A galeria permanece sem zona exclusiva e sem foco. Ela será substituída pelas superfícies reais quando a infraestrutura do Marco 4 estiver pronta.

## Organização

- `core/`: runtime, constantes, caminhos e logging.
- `config/`: configuração central e valores padrão.
- `theme/`: tokens visuais e coordenação de tema.
- `components/`: primitivas visuais reutilizáveis.
- `services/`: integrações do sistema.
- `models/`: modelos normalizados para a interface.
- `modules/`: superfícies e funcionalidades de alto nível.
- `assets/`: ícones, ilustrações e wallpapers próprios.
- `data/`: metadados de integração local.
- `scripts/`: execução e validação.
