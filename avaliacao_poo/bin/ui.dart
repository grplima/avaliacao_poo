
import 'dart:io';

import 'pessoa.dart';
import 'servico.dart';

class UI {

  Servico servico = Servico();

  menuPrincipal() {
    String opc = '';
    while(opc != '2'){
      print('Informe a opção:\n1. Gerenciar Alunos\n2. Sair');
      opc = stdin.readLineSync()!;
      switch(opc){
        case '1':
          menuGerenciarAluno();
          break;
      }
    }
  }

  menuGerenciarAluno() {
    String opc = '';
    while(opc != '2'){
      print('Informe a opção:\n1. Cadastrar aluno\n2. Voltar');
      opc = stdin.readLineSync()!;
      switch(opc){
        case '1':
          break;
      }
    }
  }

  menuCadastrarAluno() {
    print('Informe o e-mail:');
    String email = stdin.readLineSync()!;

    print('Informe o nome:');
    String nome = stdin.readLineSync()!;

    Pessoa pessoa = Pessoa();
    pessoa.nome = nome;
    pessoa.email = email;

    bool resultado = servico.cadastrarNovaPessoa(pessoa);
    if(resultado){
      print('Pessoa cadastrada com sucesso!');
    } else {
      print('Falha ao cadastrar!');
    }
  }
}