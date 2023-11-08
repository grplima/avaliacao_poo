
import 'dart:io';
import 'curso.dart';
import 'pessoa.dart';
import 'servico.dart';

class UI {

  Servico servico = Servico();

  menuPrincipal() {
    String opc = '';
    while(opc != '4'){
      print('''
--------------------------------------------
MENU PRINCIPAL:
      1. Gerenciar Alunos
      2. Gerenciar Professores
      3. Gerenciar Cursos
      4. Sair
--------------------------------------------
      ''');
      opc = stdin.readLineSync()!;
      switch(opc){
        case '1':
          menuGerenciarAluno();
          break;
        case '1':
          menuGerenciarAluno();
          break;
        case '3':
          menuGerenciarCursos();
          break;
      }
    }
  }

  menuGerenciarAluno() {
    String opc = '';
    while(opc != '4'){
      print('''
--------------------------------------------
[ALUNOS]
  Informe a opção:
      1. Cadastrar aluno
      2. Listar alunos
      3. Editar um cadastro de aluno
      4. Excluir um cadastro de aluno
      5. Voltar
--------------------------------------------
''');
      opc = stdin.readLineSync()!;
      switch(opc){
        case '1':
          menuCadastrarAluno();
          break;
      }
    }
  }

  menuCadastrarAluno() {

    print('--------------------------------------------');
    print('Informe o e-mail:');
    String email = stdin.readLineSync()!;

    print('Informe o nome:');
    String nome = stdin.readLineSync()!;

    print('Informe o nascimento DD/MM/AAAA:');
    DateTime nascimento = DateTime.parse(stdin.readLineSync()!);

    print('Informe o endereço:');
    String endereco = stdin.readLineSync()!;
    print('');

    Pessoa pessoa = Pessoa();
    pessoa.codigoPessoa = servico.codigoPessoa +1;
    pessoa.nome = nome;
    pessoa.email = email;
    pessoa.nascimento = nascimento;
    pessoa.endereco = endereco;

    

    bool resultado = servico.cadastrarNovaPessoa(pessoa);
    if(resultado){
      print('Pessoa cadastrada com sucesso!');
    } else {
      print('Falha ao cadastrar!');
    }
  }

  menuGerenciarCursos() {
    String opc = '';
    while(opc != '4'){
      print('''
--------------------------------------------
[CURSOS]
  Informe a opção:
      1. Cadastrar um curso
      2. Listar cursos
      3. Editar um curso
      4. Excluir um curso
      5. Voltar
--------------------------------------------
''');
      opc = stdin.readLineSync()!;
      switch(opc){
        case '1':
          menuCadastrarCurso();
          break;
      }
    }
  }

  menuCadastrarCurso(){
    Curso curso = Curso();

  }
}