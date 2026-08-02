# Apollo Shell

Apollo Shell é um shell moderno e modular para Hyprland, desenvolvido com [Quickshell](https://quickshell.org/) e orientado pela linguagem visual do Material Design 3 Expressive.

## Estado do projeto

Os Marcos 1, 2 e 3 estabelecem a fundação técnica, o sistema visual compartilhado e a biblioteca de componentes primitivos da primeira versão testável. A implementação atual inclui runtime, configuração central, logging, tokens semânticos e componentes reutilizáveis para superfícies, botões, controles, layouts e feedback.

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

O script de desenvolvimento adiciona os metadados locais do Apollo ao `XDG_DATA_DIRS`, evitando que o portal procure um aplicativo inexistente durante os testes.

## Documentação

- [Roadmap da v0.1](docs/ROADMAP.md)
- [Desenvolvimento](docs/DEVELOPMENT.md)
- [Status do Marco 1](docs/MILESTONE-1.md)
- [Status do Marco 2](docs/MILESTONE-2.md)
- [Status do Marco 3](docs/MILESTONE-3.md)

## Escopo atual

A implementação atual cobre a estrutura do projeto, o sistema visual e a biblioteca de primitivas. A superfície exibida no canto da tela é uma galeria técnica temporária que exercita os componentes antes da construção dos painéis reais. Widgets soltos diretamente no desktop não fazem parte desta versão.
