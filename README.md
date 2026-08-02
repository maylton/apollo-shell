# Apollo Shell

Apollo Shell é um shell moderno e modular para Hyprland, desenvolvido com [Quickshell](https://quickshell.org/) e orientado pela linguagem visual do Material Design 3 Expressive.

## Estado do projeto

O projeto está em desenvolvimento inicial. O Marco 1 estabelece a fundação técnica da primeira versão testável.

## Princípios

- Componentes pequenos e reutilizáveis.
- Separação entre interface, estado, serviços e configuração.
- Tokens visuais centralizados.
- Integrações do sistema expostas por serviços compartilhados.
- Ausência de lógica duplicada entre módulos.
- Falhas seguras quando um recurso do sistema não estiver disponível.

## Requisitos de desenvolvimento

- Linux com sessão Wayland.
- Hyprland.
- Quickshell 0.3 ou superior.
- Qt 6 fornecido pela instalação do Quickshell.
- Python 3 para as verificações estáticas.

No Arch Linux e derivados, a versão estável do Quickshell pode ser instalada pelo pacote `quickshell`.

## Validar

```bash
./scripts/check-foundation.sh
```

## Executar

```bash
./scripts/run-dev.sh
```

Também é possível iniciar diretamente:

```bash
qs -p ./shell.qml
```

## Documentação

- [Roadmap da v0.1](docs/ROADMAP.md)
- [Desenvolvimento](docs/DEVELOPMENT.md)
- [Status do Marco 1](docs/MILESTONE-1.md)

## Escopo atual

A primeira etapa cobre a estrutura do projeto, entrada do Quickshell, configuração central, logging e uma pequena superfície de diagnóstico. Widgets soltos diretamente no desktop não fazem parte desta versão.
