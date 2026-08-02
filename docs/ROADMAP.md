# Apollo Shell — Roadmap da v0.1 Alpha

> Primeira versão testável do Apollo Shell para Hyprland, construída com Quickshell e orientada pelo Material Design 3 Expressive.

## Objetivo da v0.1

A v0.1 será uma *vertical slice* funcional do conceito visual oficial: dock modular, launcher, dashboard esquerdo, central de controle, temas claro e escuro, animações expressivas e integrações básicas com o sistema.

Os relógios e demais widgets soltos diretamente na área de trabalho não fazem parte desta etapa. Eles serão tratados futuramente como módulos opcionais.

## Escopo da primeira versão

### Incluído

- Dock inferior modular.
- Launcher com pesquisa e grade de aplicativos.
- Dashboard lateral esquerdo.
- Central de controle lateral direita.
- Temas claro e escuro.
- Sistema visual Material Design 3 Expressive.
- Integração inicial com Hyprland.
- Aplicativos, workspaces, áudio, brilho, bateria e mídia com dados reais.
- Funcionamento inicial em um monitor.

### Fora do escopo

- Widgets soltos no desktop.
- Editor visual de widgets.
- Sistema de plugins.
- Central completa de notificações.
- Configuração gráfica avançada.
- Sincronização de temas externos.
- Suporte avançado a múltiplos monitores.

---

## Marco 0 — Especificação visual

### Bloco 0.1 — Inventário das telas

Separar o conceito em quatro superfícies independentes:

1. Dock inferior.
2. Launcher e visão de aplicativos.
3. Dashboard esquerdo.
4. Central de controle direita.

**Resultado esperado:** nenhuma interface será construída como uma tela monolítica.

### Bloco 0.2 — Medidas fundamentais

Definir tokens para:

- altura do dock;
- largura dos painéis;
- tamanho dos ícones;
- margens externas;
- espaçamento entre cartões;
- raios de borda;
- sombras;
- transparência;
- intensidade de blur.

Os valores deverão ser responsivos e não depender apenas de medidas fixas.

### Bloco 0.3 — Estados visuais

Documentar os estados:

- normal;
- hover;
- pressed;
- selected;
- disabled;
- loading;
- expanded;
- unavailable.

**Critério de conclusão:** cada componente interativo possui comportamento visual previsto antes de receber dados reais.

---

## Marco 1 — Fundação do projeto

### Bloco 1.1 — Estrutura inicial

```text
apollo-shell/
├── shell.qml
├── qmldir
├── core/
│   ├── Apollo.qml
│   ├── Constants.qml
│   ├── Logger.qml
│   └── Paths.qml
├── config/
│   ├── Config.qml
│   └── defaults.json
├── theme/
│   ├── Theme.qml
│   ├── Colors.qml
│   ├── Typography.qml
│   ├── Shapes.qml
│   ├── Spacing.qml
│   ├── Elevation.qml
│   └── Motion.qml
├── components/
│   ├── surfaces/
│   ├── buttons/
│   ├── controls/
│   ├── layout/
│   └── feedback/
├── services/
├── models/
├── modules/
│   ├── dock/
│   ├── launcher/
│   ├── dashboard/
│   └── controlcenter/
├── assets/
│   ├── icons/
│   ├── illustrations/
│   └── wallpapers/
└── scripts/
```

### Bloco 1.2 — Entrada mínima do Quickshell

Criar um `shell.qml` capaz de:

- iniciar sem erros;
- detectar os monitores conectados;
- instanciar uma superfície transparente de diagnóstico;
- recarregar durante o desenvolvimento;
- registrar o processo de inicialização no terminal.

### Bloco 1.3 — Configuração central

Criar uma fonte única de configuração, inicialmente com:

```qml
Config {
    property bool darkMode: false
    property bool animationsEnabled: true
    property real interfaceScale: 1.0
    property string launcherShortcut: "SUPER"
}
```

Nenhum módulo deverá ler arquivos de configuração diretamente. Todos consumirão o mesmo singleton.

### Bloco 1.4 — Logging

Criar um logger estruturado com categorias como:

```text
[APOLLO][SHELL]
[APOLLO][THEME]
[APOLLO][APPS]
[APOLLO][HYPRLAND]
[APOLLO][AUDIO]
```

**Critério de conclusão do marco:** o shell inicia, recarrega e mostra uma superfície de diagnóstico sem warnings relevantes.

---

## Marco 2 — Sistema visual compartilhado

### Bloco 2.1 — Paleta clara

Definir lavanda, lilás, rosa, pêssego, roxo expressivo, superfícies translúcidas e textos de alto e médio contraste.

### Bloco 2.2 — Paleta escura

Criar uma composição própria com fundo ameixa profundo, superfícies arroxeadas, contornos rosados discretos, estados ativos em lilás claro e texto em lavanda clara.

### Bloco 2.3 — Tipografia

```qml
Theme.typography.clock
Theme.typography.titleLarge
Theme.typography.titleMedium
Theme.typography.label
Theme.typography.body
Theme.typography.caption
```

### Bloco 2.4 — Formas

```qml
Theme.shapes.small
Theme.shapes.medium
Theme.shapes.large
Theme.shapes.extraLarge
Theme.shapes.pill
Theme.shapes.circle
```

### Bloco 2.5 — Motion

```qml
Theme.motion.fast
Theme.motion.normal
Theme.motion.slow
Theme.motion.expressiveCurve
Theme.motion.emphasizedCurve
```

### Bloco 2.6 — Tema dinâmico

Implementar alternância claro/escuro sem recriar componentes.

**Critério de conclusão:** uma galeria interna demonstra todos os tokens nos dois temas.

---

## Marco 3 — Componentes primitivos

Nenhum painel final será construído antes desta camada.

### Bloco 3.1 — Superfícies

- `ApolloSurface`
- `ApolloCard`
- `ApolloPanel`
- `ApolloPopup`
- `ApolloScrim`

### Bloco 3.2 — Botões

- `ApolloButton`
- `ApolloIconButton`
- `ApolloPillButton`
- `ApolloAppButton`

### Bloco 3.3 — Controles

- `ApolloToggle`
- `ApolloSlider`
- `ApolloProgress`
- `ApolloSegmentedControl`

### Bloco 3.4 — Layout

- `ApolloRow`
- `ApolloColumn`
- `ApolloGrid`
- `ApolloSection`
- `ApolloSpacer`

### Bloco 3.5 — Feedback

- `ApolloTooltip`
- `ApolloRipple`
- `ApolloLoadingIndicator`
- `ApolloEmptyState`

**Critério de conclusão:** montar uma galeria de componentes sem copiar estilos entre arquivos.

---

## Marco 4 — Infraestrutura da interface

### Bloco 4.1 — Gerenciador de superfícies

```qml
ShellState {
    property bool launcherOpen
    property bool dashboardOpen
    property bool controlCenterOpen
}
```

O controlador deverá impedir que superfícies incompatíveis permaneçam abertas simultaneamente.

### Bloco 4.2 — Camada de fundo

Ao abrir launcher ou painéis:

- aplicar scrim suave;
- desfocar o conteúdo quando apropriado;
- fechar ao clicar fora;
- fechar com `Esc`.

### Bloco 4.3 — Ancoragem

- Dock ancorado embaixo.
- Dashboard ancorado à esquerda.
- Central de controle ancorada à direita.
- Launcher centralizado.

### Bloco 4.4 — Responsividade

```text
compact   — telas pequenas
standard  — 1080p
expanded  — 1440p ou superior
```

**Critério de conclusão:** abrir e fechar as quatro superfícies usando controles temporários.

---

## Marco 5 — Dock inferior

### Bloco 5.1 — Estrutura visual

Separar o dock em cápsulas independentes:

```text
Launcher | Aplicativos | Workspaces | Sistema
```

### Bloco 5.2 — Favoritos simulados

- Ícones estáticos.
- Hover.
- Tooltip.
- Indicador de aplicativo ativo.
- Animação de clique.

### Bloco 5.3 — Serviço de aplicativos ativos

O `HyprlandService` fornecerá:

- janela ativa;
- classe da janela;
- workspace atual;
- lista de workspaces;
- eventos de abertura e fechamento.

### Bloco 5.4 — Indicadores de execução

Relacionar aplicações abertas aos ícones do dock.

### Bloco 5.5 — Interações

- Clique abre ou foca.
- Clique em aplicativo ativo traz a janela para frente.
- Botão central pode abrir nova instância.
- Scroll pode alternar janelas da mesma aplicação.

### Bloco 5.6 — Workspaces

Criar indicadores compactos e animados.

**Critério de conclusão:** o dock inicia aplicativos e reflete o workspace e a janela ativa.

---

## Marco 6 — Launcher

### Bloco 6.1 — Estrutura visual

- Campo de busca.
- Grade de aplicativos.
- Favoritos.
- Paginação.
- Fechamento.
- Estados vazio e carregando.

### Bloco 6.2 — Indexação de aplicativos

Criar `AppIndexService` para normalizar arquivos `.desktop`:

```qml
{
    name,
    genericName,
    icon,
    exec,
    desktopFile,
    categories,
    keywords,
    isFavorite
}
```

### Bloco 6.3 — Pesquisa

Considerar nome, nome genérico, palavras-chave, categorias e aproximação simples de termos.

### Bloco 6.4 — Execução segura

Centralizar a execução em:

```qml
AppLauncher.launch(app)
```

### Bloco 6.5 — Navegação por teclado

- Digitar inicia pesquisa.
- Setas navegam.
- `Enter` executa.
- `Esc` fecha.
- `Tab` alterna seções.

### Bloco 6.6 — Animação

Usar escala discreta, fade, expansão da busca e entrada escalonada dos ícones.

**Critério de conclusão:** abrir o launcher por atalho, pesquisar e executar um aplicativo real.

---

## Marco 7 — Dashboard esquerdo

### Bloco 7.1 — Container modular

O `DashboardGrid` aceitará módulos nos tamanhos:

```text
small
wide
tall
large
```

### Bloco 7.2 — Favoritos

Reutilizar o modelo do launcher.

### Bloco 7.3 — Mídia

Exibir capa, título, artista, play/pause, anterior, próxima e progresso básico.

### Bloco 7.4 — Calendário

Na v0.1, mostrar data e eventos locais ou simulados, sem contas externas.

### Bloco 7.5 — Atalhos rápidos

Reutilizar `ApolloPillButton`.

### Bloco 7.6 — MPRIS

Criar `MediaService` compartilhado.

**Critério de conclusão:** abrir o dashboard e controlar um player compatível com MPRIS.

---

## Marco 8 — Central de controle

### Bloco 8.1 — Cabeçalho

- Nome do usuário.
- Avatar configurável.
- Logout.
- Bloqueio.
- Desligamento.

Ações destrutivas deverão pedir confirmação.

### Bloco 8.2 — Toggles

- Wi-Fi.
- Bluetooth.
- Modo escuro.
- Modo avião.
- Não perturbe.
- Economia de energia.

### Bloco 8.3 — Áudio

Criar `AudioService` com volume, mute, dispositivo padrão e atualizações em tempo real.

### Bloco 8.4 — Brilho

Criar `BrightnessService` com limites seguros e estado indisponível em equipamentos sem backlight.

### Bloco 8.5 — Bateria

Criar `PowerService` com percentual, estado de carga e ausência de bateria.

### Bloco 8.6 — Wi-Fi e Bluetooth

Na v0.1, suportar estado atual, toggle básico, erros e indisponibilidade. Seleção detalhada ficará para uma versão posterior.

### Bloco 8.7 — Mini player

Reutilizar `MediaService`.

**Critério de conclusão:** volume, mute, brilho, tema e mídia funcionam por serviços compartilhados.

---

## Marco 9 — Integração com Hyprland

### Bloco 9.1 — IPC centralizado

```text
HyprlandService
├── dispatch()
├── activeWindow
├── activeWorkspace
├── workspaces
├── clients
└── events
```

### Bloco 9.2 — Atalhos

```ini
bind = SUPER, SPACE, exec, apolloctl toggle launcher
bind = SUPER, A, exec, apolloctl toggle dashboard
bind = SUPER, C, exec, apolloctl toggle control-center
```

### Bloco 9.3 — CLI de controle

```bash
apolloctl open launcher
apolloctl close launcher
apolloctl toggle dashboard
apolloctl theme dark
```

### Bloco 9.4 — Eventos

Atualizar sem polling excessivo quando workspace, janela ativa, aplicativos ou monitores mudarem.

**Critério de conclusão:** todas as superfícies podem ser controladas pelos atalhos do Hyprland.

---

## Marco 10 — Fidelidade visual

### Bloco 10.1 — Comparação lado a lado

Para cada superfície:

1. capturar o conceito;
2. capturar a implementação;
3. comparar proporções;
4. corrigir alinhamento;
5. corrigir densidade;
6. corrigir contraste.

### Bloco 10.2 — Ritmo de espaçamento

Revisar margens, alinhamentos, distâncias entre ícones, padding, áreas vazias e equilíbrio dos módulos.

### Bloco 10.3 — Formas

Preservar pills, círculos, squarcles, cartões expressivos e raios consistentes.

### Bloco 10.4 — Tema escuro

A versão escura deverá ser uma composição própria, não uma inversão do tema claro.

### Bloco 10.5 — Animações

- Spring suave nos painéis.
- Ripple nos controles.
- Transição tonal dos toggles.
- Interpolação de sliders.
- Stagger discreto nos grids.
- Redução de movimento configurável.

**Critério de conclusão:** as telas são imediatamente reconhecíveis como a implementação do conceito oficial.

---

## Marco 11 — Robustez

### Bloco 11.1 — Estados indisponíveis

O shell não deverá quebrar quando não houver bateria, brilho, Bluetooth, NetworkManager, player de mídia ou ícone de aplicativo.

### Bloco 11.2 — Fallbacks

- Ícone genérico.
- Avatar padrão.
- Capa de mídia padrão.
- Mensagens de serviço indisponível.
- Comandos com falha segura.

### Bloco 11.3 — Performance

Revisar componentes desnecessários, modelos duplicados, blur excessivo, polling, imagens grandes e animações invisíveis.

### Bloco 11.4 — Diagnóstico

```bash
APOLLO_DEBUG=1 qs -p apollo-shell
```

---

## Marco 12 — Empacotamento testável

### Bloco 12.1 — Desenvolvimento

```bash
./scripts/run-dev.sh
```

O script verificará dependências, encerrará a instância anterior quando apropriado, iniciará o shell e exibirá logs.

### Bloco 12.2 — Instalação local

```bash
./scripts/install-local.sh
```

Preferencialmente sem exigir root.

### Bloco 12.3 — Exemplo para Hyprland

```text
examples/hyprland-apollo.conf
```

O arquivo poderá ser importado sem substituir a configuração existente.

### Bloco 12.4 — Página de diagnóstico

Mostrar versão do Quickshell, conexão com Hyprland, áudio, brilho, bateria, rede, Bluetooth, MPRIS e erros recentes.

---

## Definição de pronto da v0.1 Alpha

A primeira versão estará pronta para testes quando:

- iniciar com um único comando;
- não modificar permanentemente o desktop;
- exibir dock com aplicativos e workspaces reais;
- abrir o launcher por atalho;
- listar, pesquisar e executar aplicativos;
- abrir e fechar os painéis laterais;
- controlar áudio, brilho e mídia;
- alternar temas claro e escuro;
- adaptar-se a 1366×768, 1920×1080 e 2560×1440;
- continuar funcionando quando algum serviço estiver ausente;
- não incluir widgets soltos no desktop;
- reutilizar os mesmos serviços, modelos e componentes.

## Ordem de execução

```text
Fundação
→ Tokens visuais
→ Componentes básicos
→ Gerenciador de superfícies
→ Dock
→ Launcher
→ Dashboard
→ Central de controle
→ Serviços reais
→ Integração Hyprland
→ Animações
→ Fidelidade visual
→ Testes e empacotamento
```

O primeiro ponto realmente utilizável será alcançado ao final do Marco 6, com dock e launcher funcionais.