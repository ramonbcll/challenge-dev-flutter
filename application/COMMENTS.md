## Arquitetura e Estrutura do Projeto
Este projeto Flutter foi organizado adotando uma arquitetura clara, modular e orientada a camadas, que facilita manutenção e escalabilidade.

 - Organização das Pastas
 - Gerenciamento de Estado
 - Navegação e Rotas
 - Injeção de dependência manual
 - Separação entre UI, estado e dados

### Descrição da estrutura

 - actions/: Contém funções utilitárias relacionadas às ações do usuário nas telas, como adicionar, editar e excluir alunos. Centralizar ações ajuda a manter a UI enxuta e facilita reutilização e testes.
 - core/: Serviços centrais, como injeção de dependência (`injector.dart`), cliente HTTP personalizado e outras infraestruturas compartilhadas. Isso isola recursos globais do resto do app.
 - models/: Definição das entidades do domínio, como `Student` e `StudentLog`. Eles representam os dados e regras essenciais que o app manipula.
 - provider/: Controladores que gerenciam o estado da aplicação usando `ChangeNotifier`. Cada controller encapsula lógica de negócio, como buscar dados via repositório, aplicar filtros e notificar a UI sobre mudanças.
 - repositories/: Implementação do padrão Repository para abstrair o acesso a dados, que neste caso é uma API REST. Isso permite trocar a fonte de dados futuramente sem impacto na UI.
 - screens/: Todas as telas (pages) do app. Cada tela é focada numa funcionalidade, como listagem, registro, notificações etc.
 - theme/: Definição do tema e estilos globais do app.
 - utils/: Funções e helpers utilitários que são usados em vários pontos do código.
 - widgets/: Componentes visuais reutilizáveis, como cards de aluno, campos customizados, barra de navegação, etc.

## Bibliotecas
- `cupertino_icons`
- `dio`
- `pretty_dio_logger`
- `auto_injector`
- `mask_text_input_formatter`
- `intl`

## Possíveis melhorias
- Interface de login com diferentes permissões - apenas visualização e administração
- Persistência de dados para a lista de alunos e para histórico de notificações

## Melhorias adicionais realizadas
 - `TextField` de Buscar realizando filtro
 - `BottomNavigationBarItem` transicionando entre as telas de Menu, Ajuda, Notificações e Perfil
 - `BottomNavigationBarItem` de notificações ativo com histórico de inclusão, alteração e exclusão de alunos

## Environment
 - Flutter: 3.32.7
 - Dart: 3.8.1
