
O objetivo deste desafio é avaliar as competências técnicas dos candidatos Regras e requisitos técnicos estão detalhadas neste documento.

# Especificações Técnicas
- **Mobile:**
  - Framework Flutter

- **UX/UI:** Utilizar preceitos e regras de material 3

- **Idioma de escrita do código:** Inglês

# Requisitos
## Contextualização
Considere que uma Instituição de Ensino Superior precisa de uma solução
para cadastrar e gerenciar os alunos em turmas online.
Para realizar a matrícula, é necessário que o cadastro do aluno tenha sido realizado.

O desafio consiste em criar uma aplicação para o cadastro de alunos conforme os critérios de aceitação.

## Mockups de interface
A seguir, são apresentados alguns mockups de interface como um guia. Fique à vontade para usar sua criatividade na criação das telas.

* Cadastrar aluno  
![Listagem de Alunos](/mockups/student.png)  

* Editar/Excluir Aluno  
![Listagem de Alunos](/mockups/edit_student.png)  

![Listagem de Alunos](/mockups/list_student.png)  

## Histórias do Usuário
- **Sendo** um usuário administrativo da Instituição
- **Quero** gerenciar cadastros de alunos
- **Para** que eu possa realizar a matrícula do aluno

### Critérios de aceite:

#### Cenário: Cadastrar novo aluno
- **Dado** que estou na tela de Listagem de Alunos
- **Quando** clico em Adicionar Aluno
- **Então** abre a tela de Cadastro do Aluno
- **Então** exibe os campos obrigatórios vazios

####
- **Dado** que inseri dados válidos nos campos
- **Quando** clico em Adicionar
- **Então** cria o novo aluno na base
- **Então** retorna mensagem de sucesso

####
- **Dado** que inseri dados inválidos nos campos
- **Então** retorna mensagem de necessidade de preenchimento dos campos obrigatórios

####
- **Dado** que inseri dados válidos nos campos
- **Quando** clico na up navigation e/ou utilizo gestos
- **Então** retorna para tela Consulta de Alunos
- **Então** não persiste a gravação dos dados no banco

#### Cenário: Listar alunos cadastrados
- **Dado** que estou na tela home da aplicação
- **Então** abre a tela com listagem de Alunos
- **Então** abre a tela com ícone de edição de Alunos
- **Então** abre a tela com ícone de exclusão de Alunos
- **Então** abre a tela com botão Adicionar Aluno

#### Cenário: Editar cadastro de aluno
- **Dado** que estou na listagem de alunos
- **Quando** clico no ícone de Editar aluno
- **Então** abre a tela de Editar Aluno
- **Então** exibe os campos preenchidos
- **Então** habilita alteração dos campos editáveis

####
- **Dado** que estou na tela de Edição do Aluno
- **Quando** clico em Salvar
- **Então** grava os dados editáveis na base
- **Então** retorna mensagem de sucesso

####
- **Dado** que estou na tela de Edição do Aluno
- **Quando** clico na up navigation e/ou utilizo gestos
- **Então** retorna para a tela de Listagem de Alunos
- **Então** não persiste a gravação dos dados

#### Cenário: Excluir cadastro de aluno
- **Dado** que estou na listagem de alunos
- **Quando** clico no ícone de Excluir aluno
- **Então** exibe a modal de confirmação de exclusão

####
- **Dado** que estou na modal de confirmação de exclusão
- **Quando** clico em Excluir aluno
- **Então** então exclui o registro do aluno
- **Então** retorna mensagem de sucesso

####
- **Dado** que estou na modal de confirmação de exclusão
- **Quando** clico em Cancelar
- **Então** então fecha a modal e não persiste a exclusão

## Campos obrigatórios:
- **RA** (não editável) (chave única)
- **Nome** (editável)
- **Email** (editável)
- **Data de nascimento** (editável)
- **CPF** (não editável)

# Critérios de avaliação
- Qualidade de escrita do código
- Organização do projeto
- Lógica da solução implementada
- Utilização do Git (quantidade e descrição dos commits, Git Flow, ...)
- Validações
- Tratamento de erros

# Desejável

- Testes de unidade;

# Endpoints disponíveis para consumo:

## Endpoint student

POST - https://653c0826d5d6790f5ec7c664.mockapi.io/api/v1/student

exemplo de payload:
```
{
  "name": "Thiago Cury",
  "email": "thiago@gmail.com",
  "birthdate": "1983-11-10",
  "academic_record": "1234",
  "cpf": "00271700040"
}
```

exemplo de response:
```
{
	"createdAt": "2023-11-02T06:52:27.344Z",
	"name": "Thiago Cury",
	"birthdate": "1983-11-10",
	"cpf": "00271700040",
	"email": "thiago@gmail.com",
	"academic_record": "1234",
	"id": "1"
}
```

GET - https://653c0826d5d6790f5ec7c664.mockapi.io/api/v1/student

GET - https://653c0826d5d6790f5ec7c664.mockapi.io/api/v1/student/:id

DELETE - https://653c0826d5d6790f5ec7c664.mockapi.io/api/v1/student/:id

# Observações
- As APIs foram criadas utilizando Mock.api, ou seja, não são apis oficiais, e sim, apenas de teste;
- O endpoint student são rest, você pode utilizar os verbos GET/POST/PUT/DELETE para realizar os testes necessários;

# Instruções de entrega
1. Crie um fork do repositório no seu GitHub
2. Faça o push do código desenvolvido no seu Github
3. Inclua um arquivo chamado COMMENTS.md explicando
    - Decisão da arquitetura utilizada
    - Lista de bibliotecas de terceiros utilizadas
    - O que você melhoraria se tivesse mais tempo
    - Quais requisitos obrigatórios que não foram entregues
4. Informe ao recrutador quando concluir o desafio junto com o link do repositório
