# Marco 3 — Componentes primitivos

Status: **implementado na branch `feat/milestone-3-components` e aguardando validação de runtime**.

## Entregas

### Superfícies

- [x] `ApolloSurface`
- [x] `ApolloCard`
- [x] `ApolloPanel`
- [x] `ApolloPopup`
- [x] `ApolloScrim`

### Botões

- [x] `ApolloButton`
- [x] `ApolloIconButton`
- [x] `ApolloPillButton`
- [x] `ApolloAppButton`

### Controles

- [x] `ApolloToggle`
- [x] `ApolloSlider`
- [x] `ApolloProgress`
- [x] `ApolloSegmentedControl`

### Layout

- [x] `ApolloRow`
- [x] `ApolloColumn`
- [x] `ApolloGrid`
- [x] `ApolloSection`
- [x] `ApolloSpacer`

### Feedback

- [x] `ApolloTooltip`
- [x] `ApolloRipple`
- [x] `ApolloLoadingIndicator`
- [x] `ApolloEmptyState`

## Arquitetura

Cada família possui um `qmldir` próprio. Os módulos importam somente os grupos necessários:

```qml
import "../../components/surfaces" as Surfaces
import "../../components/buttons" as Buttons
import "../../components/controls" as Controls
import "../../components/layout" as ApolloLayout
import "../../components/feedback" as Feedback
```

As primitivas consomem exclusivamente o sistema visual compartilhado e não dependem de módulos, serviços ou modelos.

## Reutilização

`ApolloSurface` concentra:

- cor da superfície;
- contorno;
- raio;
- padding;
- clipping;
- animação de mudança de cor;
- área de conteúdo padrão.

`ApolloCard`, `ApolloPanel` e `ApolloPopup` especializam esse componente sem repetir sua implementação.

`ApolloButton` concentra os estados e a estrutura visual comum. `ApolloIconButton` e `ApolloPillButton` são especializações diretas.

## Galeria

A antiga galeria de tokens foi transformada em uma galeria interativa de componentes. Ela instancia todas as 22 primitivas para detectar problemas de carregamento antes que os painéis reais sejam construídos.

A galeria demonstra:

- superfícies e scrim;
- botões de texto, pill, ícone e aplicativo;
- toggle, slider, progresso e segmentos;
- rows, columns, grids, sections e spacers;
- tooltip, loading, ripple e empty state;
- alternância entre tema claro e escuro.

## Validação automatizada

`./scripts/check-foundation.sh` agora executa também `scripts/check-components.py`, que verifica:

1. presença de todos os arquivos;
2. registro correto nos `qmldir`;
3. ausência de cores hexadecimais nos componentes;
4. consumo do sistema de tokens;
5. imports necessários para tipos Qt;
6. ausência de dependências em camadas superiores;
7. instanciação de todas as primitivas na galeria;
8. exposição da área de conteúdo reutilizável em `ApolloSurface`;
9. estados essenciais do botão base.

## Critério de conclusão

O Marco 3 será considerado concluído quando:

1. `./scripts/check-foundation.sh` passar sem erros;
2. o GitHub Actions concluir com sucesso;
3. a galeria iniciar no Hyprland sem tipos indisponíveis;
4. o Caelestia continuar funcionando em paralelo;
5. botões responderem a hover e clique;
6. toggle, slider e segmentos responderem à interação;
7. o ripple executar ao clicar em sua área de demonstração;
8. a troca de tema atualizar todos os componentes;
9. o scroll permitir visualizar toda a galeria;
10. não houver warnings relevantes no terminal.

## Validação manual

```bash
cd ~/src/apollo-shell
git fetch origin
git switch feat/milestone-3-components
git pull --ff-only

./scripts/check-foundation.sh
APOLLO_DEBUG=1 ./scripts/run-dev.sh
```

Teste na galeria:

- alterne o tema pelo botão no cabeçalho;
- clique nos diferentes botões;
- altere o toggle;
- mova o slider;
- troque o segmento selecionado;
- clique na área de ripple;
- role até o fim da galeria.

Para encerrar apenas o Apollo, use `Ctrl+C` no terminal em que `run-dev.sh` está ativo.

## Próxima etapa

O Marco 4 implementará a infraestrutura de superfícies: estado global, exclusividade entre overlays, scrim compartilhado, fechamento por clique externo e `Esc`, ancoragem e densidades responsivas.
