# Marco 2 — Sistema visual compartilhado

Status: **implementado na branch `feat/milestone-2-design-system` e aguardando validação de runtime**.

## Entregas

- [x] Paleta semântica clara alinhada ao conceito visual do Apollo.
- [x] Paleta escura própria, sem simples inversão da paleta clara.
- [x] Papéis adicionais em lavanda, rosa, pêssego, ameixa e menta.
- [x] Tokens de tipografia com papéis para relógio, display, títulos, corpo e labels.
- [x] Tokens de formas para cartões, painéis, controles, pills e círculos.
- [x] Escala central de espaçamento e alvos mínimos de interação.
- [x] Níveis de elevação compartilhados.
- [x] Durações e curvas de movimento compartilhadas.
- [x] Singleton `Theme` como ponto único de acesso ao sistema visual.
- [x] Alternância reativa entre tema claro e escuro por `Config.darkMode`.
- [x] Respeito global a `animationsEnabled` e `interfaceScale`.
- [x] Migração da superfície de diagnóstico para uso exclusivo dos tokens.
- [x] Galeria interna para inspeção visual da paleta e dos papéis principais.
- [x] Validação automatizada contra estilos duplicados na galeria.
- [x] Metadados `.desktop` locais para eliminar o aviso do portal durante o desenvolvimento.

## Arquitetura

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

Os módulos acessam o sistema visual por meio de:

```qml
import "../../theme" as Tokens

Tokens.Theme.colors
Tokens.Theme.typography
Tokens.Theme.shapes
Tokens.Theme.spacing
Tokens.Theme.elevation
Tokens.Theme.motion
```

## Critério de conclusão

O Marco 2 é considerado concluído quando:

1. `./scripts/check-foundation.sh` passa sem erros;
2. o Apollo inicia em uma sessão Wayland com Quickshell 0.3+;
3. a galeria utiliza exclusivamente tokens compartilhados;
4. a mudança de `darkMode` atualiza a interface sem recriar componentes;
5. a escala de interface altera medidas e tipografia de forma consistente;
6. desabilitar animações reduz as durações para zero;
7. o processo não interfere na instância do Caelestia;
8. o aviso de metadados ausentes do portal deixa de aparecer ao usar `run-dev.sh`.

## Validação manual

```bash
./scripts/check-foundation.sh
APOLLO_DEBUG=1 ./scripts/run-dev.sh
```

Com o Apollo aberto, altere temporariamente em `config/defaults.json`:

```json
"darkMode": true
```

Depois retorne para:

```json
"darkMode": false
```

A galeria deve trocar de paleta sem fechar o processo. Para encerrar apenas o Apollo, use `Ctrl+C` no terminal em que `run-dev.sh` está ativo.

## Saída visual esperada

Uma galeria arredondada no canto superior esquerdo apresenta:

- versão atual do Apollo;
- monitor detectado;
- modo claro ou escuro;
- quatro cores expressivas;
- amostra de superfície e tipografia;
- valores de toque, raio e movimento.

A galeria é temporária e não faz parte do futuro sistema de widgets de desktop.

## Próxima etapa

O Marco 3 implementará os componentes primitivos reutilizáveis: superfícies, cartões, painéis, botões, controles, auxiliares de layout e feedback visual.
