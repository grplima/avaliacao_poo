import 'dart:io';
import 'pessoa.dart';
import 'servico.dart';

class UI {
  Servico servico = Servico();

  void menuPrincipal() {
    String opc = '';
    while (opc != '3') {
      print('''
--------------------------------------------
MENU PRINCIPAL:
      1. Gerenciar Pessoas
      2. Gerenciar Cursos
      3. Sair
--------------------------------------------
      ''');
      opc = stdin.readLineSync()!;
      switch (opc) {
        case '1':
          menuGerenciarPessoas();
          break;
        case '2':
          menuGerenciarCursos();
          break;
        case '3':
          break;
      }
    }
  }

  void menuGerenciarPessoas() {
    String opc = '';
    while (opc != '5') {
      print('''
--------------------------------------------
[PESSOAS]
  Informe a opção:
      1. Cadastrar pessoa
      2. Listar pessoas
      3. Editar um cadastro de pessoa
      4. Excluir um cadastro de pessoa
      5. Voltar
--------------------------------------------
      ''');
      opc = stdin.readLineSync()!;
      switch (opc) {
        case '1':
          menuCadastrarPessoa();
          break;
        case '2':
          listarPessoas();
          break;
        case '3':
          menuEditarCadastro();
          break;
        case '4':
          menuExcluirCadastro();
          break;
      }
    }
  }

  void menuCadastrarPessoa() {
    print('--------------------------------------------');
    print('Informe o e-mail:');
    String email = stdin.readLineSync()!;

    print('Informe o nome:');
    String nome = stdin.readLineSync()!;

    print('Informe o nascimento (DD/MM/AAAA):');
    String dataNascimentoStr = stdin.readLineSync()!;
    DateTime nascimento = DateTime.parse(dataNascimentoStr);

    print('Informe o endereço (opcional):');
    String? endereco = stdin.readLineSync();

    final pessoa = Pessoa(
        codigo: servico.listaPessoas.length + 1,
        email: email,
        nome: nome,
        nascimento: nascimento,
        endereco: endereco);

    bool resultado = servico.cadastrarNovaPessoa(pessoa);
    if (resultado) {
      print('Pessoa cadastrada com sucesso!');
    } else {
      print('Falha ao cadastrar!');
    }
  }

  void listarPessoas() {
    final pessoas = servico.listarPessoas();
    if (pessoas.isEmpty) {
      print('Nenhuma pessoa cadastrada.');
    } else {
      print('Pessoas cadastradas:');
      for (var pessoa in pessoas) {
        print(
            'Código: ${pessoa.codigo}, Nome: ${pessoa.nome}, E-mail: ${pessoa.email}');
      }
    }
  }

  void menuEditarCadastro() {
    print('Informe o código da pessoa a ser editada:');
    final codigo = int.parse(stdin.readLineSync()!);

    final pessoa = servico.listaPessoas.firstWhere((p) => p.codigo == codigo,
        orElse: () => Pessoa(codigo: 0, email: '', nome: '', nascimento: DateTime.now()));
    if (pessoa.codigo == 0) {
      print('Pessoa não encontrada.');
      return;
    }

    print('Informe o novo e-mail:');
    final novoEmail = stdin.readLineSync()!;

    print('Informe o novo nome:');
    final novoNome = stdin.readLineSync()!;

    final novaPessoa = Pessoa(
        codigo: pessoa.codigo,
        email: novoEmail,
        nome: novoNome,
        nascimento: pessoa.nascimento,
        endereco: pessoa.endereco);
    if (servico.editarCadastro(novaPessoa)) {
      print('Cadastro editado com sucesso!');
    } else {
      print('Falha ao editar o cadastro.');
    }
  }

  void menuExcluirCadastro() {
    print('Informe o código da pessoa a ser excluída:');
    final codigo = int.parse(stdin.readLineSync()!);

    if (servico.excluirCadastro(codigo)) {
      print('Cadastro excluído com sucesso!');
    } else {
      print('Falha ao excluir o cadastro.');
    }
  }

  void iniciar() {
    menuPrincipal();
  }

menuGerenciarCursos(){
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
}

}

