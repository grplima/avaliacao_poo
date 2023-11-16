import 'dart:io';

import '../modelo/aluno.dart';
import '../modelo/curso.dart';
import '../modelo/pessoa.dart';
import '../modelo/professor.dart';
import '../servico/servico.dart';
import 'package:intl/intl.dart';

class UI {
  Servico servico = Servico();

  menuPrincipal() {
    String opc = '';
    while (opc != '10') {
      print('''
      ╔═════════════════════════════╗
      ║        MENU PRINCIPAL       ║
      ╠═════════════════════════════╣
      ║ Selecione uma opção:        ║
      ╠═════╦═══════════════════════╣
      ║  1  ║   Gerenciar Alunos    ║
      ╠═════╬═══════════════════════╣     
      ║  2  ║   Gerenciar Professor ║
      ╠═════╬═══════════════════════╣     
      ║  3  ║   Gerenciar Curso     ║
      ╠═════╬═══════════════════════╣        
      ║  4  ║   Gerenciar Nota      ║
      ╠═════╬═══════════════════════╣        
      ║  10 ║   Sair                ║
      ╚═════╩═══════════════════════╝                        
          ''');
      opc = stdin.readLineSync()!;
      switch (opc) {
        case "1":
          menuGerenciarAluno();
          break;
        case '2':
          menuGerenciarProfessor();
          break;
        case '3':
          menuGerenciarCurso();
          break;
        case '4':
          menuGerenciarNota();
          break;
        
        default:
        print('opção inválida');
          break;
      }
    }
  }

  menuGerenciarAluno() {
    String opc = '';
    while (opc != '10') {
      print('''
      ┌──────────────────────────┐                          
      │ Gerenciar alunos         │
      ├────┬─────────────────────┤
      │  1 │ Cadastrar aluno     │
      ├────┼─────────────────────┤             
      │  2 │ Editar aluno        │    
      ├────┼─────────────────────┤       
      │  3 │ Excluir aluno       │       
      ├────┼─────────────────────┤       
      │  4 │ Listar todos alunos │
      ├────┼─────────────────────┤
      │ 10 │ Voltar              │
      └────┴─────────────────────┘
''');
      
      opc = stdin.readLineSync()!;
      switch (opc) {
        case '1':
          menuCadastrarAluno();
          break;
        case '2':
          menuAlterarAluno();
          break;
        case '3':
          menuExcluirAluno();
          break;
        case '4':
          menuListarAluno();
          break;
      }
    }
  }

  menuCadastrarAluno() {
    print('\nInforme o e-mail:');
    String email = stdin.readLineSync()!;

    print('Informe o nome:');
    String nome = stdin.readLineSync()!;

    print('Informe a data de nascimento: dd/MM/yyyy');
    String salvarNascimento = stdin.readLineSync()!;
    DateFormat df = DateFormat('dd/MM/yyyy');
    DateTime nascimento = df.parse(salvarNascimento);

    print('Informe o endereço completo:');
    String endereco = stdin.readLineSync()!;

    Aluno aluno = Aluno(nome, nascimento, endereco);
    aluno.nome = nome;
    aluno.email = email;
    aluno.nascimento = nascimento;
    aluno.endereco = endereco;

    bool resultado = servico.cadastrarPessoa(aluno);
    if (resultado) {
      print('''
      ┌──────────────────────────────────────────┐
      │   ✔  Pessoa cadastrada com sucesso  ✔    │
      └──────────────────────────────────────────┘
          ''');
    } else {
      print('''
      ┌──────────────────────────────────────────┐
      │   X       Falha ao cadastrar        X    │
      └──────────────────────────────────────────┘
      ''');
    }
  }

  menuAlterarAluno() {
    print('\nInforme o código da pessoa a ser editada:');
    final codigo = int.parse(stdin.readLineSync()!);

    final pessoa = servico.listarPessoas().firstWhere((p) => p.codigo == codigo,
        orElse: () => Pessoa());
    if (pessoa.codigo == 0) {
      print('''
      ┌──────────────────────────────────────────┐
      │   X       Pessoa não encontrada     X    │
      └──────────────────────────────────────────┘
      ''');
      return;
    }

    print('\nInforme o novo e-mail:');
    final novoEmail = stdin.readLineSync()!;

    print('Informe o novo nome:');
    final novoNome = stdin.readLineSync()!;

    print('Informe a nova data de nascimento: (dd/mm/aaaa)');
    String salvarNovaNascimento = stdin.readLineSync()!;
    DateFormat ndf = DateFormat('dd/MM/yyyy');
    DateTime novoNascimento = ndf.parse(salvarNovaNascimento);

    print('Informe o novo endereco:');
    final novoEndereco = stdin.readLineSync()!;

        pessoa.email = novoEmail;
        pessoa.nome = novoNome;
        pessoa.nascimento = novoNascimento;
        pessoa.endereco = novoEndereco;

    bool resultado = servico.cadastrarPessoa(pessoa);
    if (resultado) {
      print('''
      ┌──────────────────────────────────────────┐
      │   ✔  Pessoa cadastrada com sucesso  ✔   │
      └──────────────────────────────────────────┘
          ''');
    } else {
      print('''
      ┌──────────────────────────────────────────┐
      │   X       Falha ao cadastrar        X    │
      └──────────────────────────────────────────┘
      ''');
    }
  }

  menuExcluirAluno() {
    print('\nDigite o código do aluno a ser excluído:');
    int excCodigo = int.parse(stdin.readLineSync()!);

    Pessoa pessoa = Pessoa();
    pessoa.codigo = excCodigo;

    bool alunoFoiExcluido = servico.excluirPessoa(excCodigo);
    if (alunoFoiExcluido) {
      print('''
          ┌──────────────────────────────────────────┐
          │    ✔  Aluno excluido com sucesso  ✔     │
          └──────────────────────────────────────────┘
          ''');
    } else {
      print('''
          ┌──────────────────────────────────────────┐
          │   X        Falha ao excluir         X    │
          └──────────────────────────────────────────┘
      ''');
    }
  }

  menuListarAluno() {
    List<Pessoa> listaPessoas = servico.listarAlunos();

    for (Pessoa pessoa in listaPessoas) {
      print(pessoa.toString());
    }
  }

  menuGerenciarProfessor() {
    String opc = '';
    while (opc != '10') {

print('''
      ┌───────────────────────────────┐                          
      │ Gerenciar professores         │
      ├────┬──────────────────────────┤
      │  1 │ Cadastrar professor      │
      ├────┼──────────────────────────┤             
      │  2 │ Edtar professor          │    
      ├────┼──────────────────────────┤       
      │  3 │ Excluir professor        │       
      ├────┼──────────────────────────┤       
      │  4 │ Listar todos professores │
      ├────┼──────────────────────────┤
      │ 10 │ Voltar                   │
      └────┴──────────────────────────┘
''');

      
      opc = stdin.readLineSync()!;
      switch (opc) {
        case '1':
          menuCadastrarProfessor();
          break;
        case '2':
          menuAlterarProfessor();
          break;
        case '3':
          menuExcluirProfessor();
          break;
        case '4':
          menuListarProfessor();
          break;
      }
    }
  }

  menuCadastrarProfessor() {
    print('\nInforme o e-mail:');
    String email = stdin.readLineSync()!;

    print('Informe o nome:');
    String nome = stdin.readLineSync()!;

    print('Informe a data de nascimento: dd/MM/yyyy');
    String salvarNascimento = stdin.readLineSync()!;
    DateFormat df = DateFormat('dd/MM/yyyy');
    DateTime nascimento = df.parse(salvarNascimento);

    print('Informe o endereço completo:');
    String endereco = stdin.readLineSync()!;

    print('Informe o salário do professor:');
    double salario = double.parse(stdin.readLineSync()!);

    Professor professor = Professor();
    professor.nome = nome;
    professor.email = email;
    professor.nascimento = nascimento;
    professor.endereco = endereco;

    bool resultado = servico.cadastrarPessoa(professor);
    if (resultado) {
      print('''
          ┌────────────────────────────────────────────────┐
          │    ✔  Professor cadastrado com sucesso  ✔     │
          └────────────────────────────────────────────────┘
          ''');
    } else {
      print('''
          ┌────────────────────────────────────────────┐
          │   X        Falha ao cadastrar         X    │
          └────────────────────────────────────────────┘
      ''');
    } 
  }

  menuAlterarProfessor() {}

  menuExcluirProfessor() {
  print('\nDigite o código do professor a ser excluído:');
    int excCodigoProf = int.parse(stdin.readLineSync()!);
    Professor professor = Professor();
    professor.codigo = excCodigoProf;


    bool professprFoiExcluido = servico.excluirPessoa(excCodigoProf);
    // print('\nDigite o codigo do professor a ser excluído:');
    // String email = stdin.readLineSync()!;

    // Pessoa pessoa = Pessoa();
    // pessoa.email = email;

    // bool professorFoiExcluido = servico.excluirPessoa(pessoa);
    if (professprFoiExcluido) {
      print('''
          ┌──────────────────────────────────────────────┐
          │    ✔  Professor excluido com sucesso  ✔     │
          └──────────────────────────────────────────────┘
          ''');
    } else {
      print('''
          ┌──────────────────────────────────────────┐
          │   X        Falha ao excluir         X    │
          └──────────────────────────────────────────┘
      ''');
    } 
  }

  menuListarProfessor() {
    List<Professor> listaProfessores = servico.listarProfessores();

    for (Professor professor in listaProfessores) {
      print(professor.toString());
    }
  }

  menuGerenciarCurso() {
    String opc = '';
    while (opc != '10') {
      print('''
      ┌───────────────────────────────┐                          
      │ Gerenciar cursos              │
      ├────┬──────────────────────────┤
      │  1 │ Cadastrar curso          │
      ├────┼──────────────────────────┤             
      │  2 │ Edtar curso              │    
      ├────┼──────────────────────────┤       
      │  3 │ Excluir curso            │       
      ├────┼──────────────────────────┤       
      │  4 │ Listar todos os cursos   │
      ├────┼──────────────────────────┤
      │ 10 │ Voltar                   │
      └────┴──────────────────────────┘
''');
      
      opc = stdin.readLineSync()!;
      switch (opc) {
        case '1':
          menuCadastrarCurso();
          break;
        case '2':
          menuAlterarCurso();
          break;
        case '3':
          menuExcluirCurso();
          break;
        case '4':
          menuListarCurso();
          break;
      }
    }
  }

  menuCadastrarCurso() {
    print('\nInforme o nome do curso a ser criado:');
    String nome = stdin.readLineSync()!;

    print('Informe a quantidade total de alunos:');
    int totalAlunos = int.parse(stdin.readLineSync()!);

    Curso curso = Curso();
    curso.nome = nome;
    curso.totalAlunos = totalAlunos;

    servico.adicionarCurso(curso);
  }

  menuAlterarCurso() {
    //1 add aluno, 2 add professor, 3 remover pessoa
    String opc = '';
    while (opc != '10') {
      print('''
      ┌───────────────────────────────┐                          
      │ Alterar curso                 │
      ├────┬──────────────────────────┤
      │  1 │ Adicionar aluno          │
      ├────┼──────────────────────────┤             
      │  2 │ Adicionar professor      │    
      ├────┼──────────────────────────┤       
      │  3 │ Excluir pessoa do curso  │       
      ├────┼──────────────────────────┤       
      │ 10 │ Voltar                   │
      └────┴──────────────────────────┘
      ''');
      
      opc = stdin.readLineSync()!;
      switch (opc) {
        case '1':
          menuAddAlunoNoCurso();
          break;
        case '2':
          menuAddProfessorNoCurso();
          break;
        case '3':
          menuRemoverPessoaDoCurso();
          break;
      }
    }
  }

  menuAddAlunoNoCurso() {
    print('\nDigite o código do curso a receber um aluno: ');
    int codigoCurso = int.parse(stdin.readLineSync()!);
    Curso? curso = servico.buscarCursoPorCodigo(codigoCurso);

    if (curso != null) {
      print("Digite o código do aluno a ser adicionado nesse curso:");
      int codigoAluno = int.parse(stdin.readLineSync()!);
      Aluno? aluno = servico.buscarAlunoPorCodigo(codigoAluno);

      if (aluno != null) {
        servico.addAlunoNoCurso(aluno, curso);
      } else {
        
        print('''
      ┌────────────────────────────────────────────────────────┐
      │    X  Aluno com código $codigoAluno não existe!  X     │
      └────────────────────────────────────────────────────────┘
        ''');
      }
    } else {
      print('''
      ┌────────────────────────────────────────────────────────┐
      │    X  Curso com código $codigoCurso não existe!  X     │
      └────────────────────────────────────────────────────────┘
        ''');
    }
  }

  menuAddProfessorNoCurso() {
    print('\nDigite o código do curso a receber o professor: ');
    int codigoCurso = int.parse(stdin.readLineSync()!);
    Curso? curso = servico.buscarCursoPorCodigo(codigoCurso);

    if (curso != null) {
      print("Digite o código do professor a ser adicionado nesse curso:");
      int codigoProfessor = int.parse(stdin.readLineSync()!);
      Professor? professor = servico.buscarProfessorPorCodigo(codigoProfessor);

      if (professor != null) {
        servico.addProfessorNoCurso(professor, curso);
      } else {
        print('''
      ┌────────────────────────────────────────────────────────────────┐
      │    X  Professor com código $codigoProfessor não existe!  X     │
      └────────────────────────────────────────────────────────────────┘
        ''');
      }
    } else {

      print('''
      ┌────────────────────────────────────────────────────────────────┐
      │      X    Curso com código $codigoCurso não existe!    X       │
      └────────────────────────────────────────────────────────────────┘
      
      ''');
    }
  }

  menuRemoverPessoaDoCurso() {
    print('\nDigite o código do curso que a pessoa será removida: ');
    int codigoCurso = int.parse(stdin.readLineSync()!);
    Curso? curso = servico.buscarCursoPorCodigo(codigoCurso);

    if (curso != null) {
      print("Digite o código da pessoa a ser removida do curso:");
      int codigoPessoa = int.parse(stdin.readLineSync()!);
      Pessoa? pessoa = servico.buscarPessoaPorCodigo(codigoPessoa);

      if (pessoa != null) {
        servico.excluirPessoaDoCurso(pessoa, curso);
      } else {
        print('''
      ┌──────────────────────────────────────────────────────────────────┐
      │      X    Pessoa com código $codigoPessoa não existe!    X       │
      └──────────────────────────────────────────────────────────────────┘
''');
      }
    } else {
      print('''
      ┌──────────────────────────────────────────────────────────────────┐
      │       X    Curso com código $codigoCurso não existe!    X        │
      └──────────────────────────────────────────────────────────────────┘
''');
    }
  }

  menuExcluirCurso() {
    print('\nDigite o código do curso a ser excluído:');
    int codigo = int.parse(stdin.readLineSync()!);

    bool cursoFoiExcluido = servico.excluirCurso(codigo);
    if (cursoFoiExcluido) {
      print('''
      ┌──────────────────────────────────────────────┐
      │      ✔  Curso excluído com sucesso  ✔       │
      └──────────────────────────────────────────────┘
''');
    } else {
      print( '''
      ┌──────────────────────────────────────────┐
      │   X      Falha ao excluir curso     X    │
      └──────────────────────────────────────────┘
'''); 
    }
  }

  menuListarCurso() {
    List<Curso> listaCursos = servico.listarCursos();

    for (Curso curso in listaCursos) {
      print(curso.toString());
    }
  }

  menuGerenciarNota() {
    String opc = '';
    while (opc != '10') {
      print('''
      ┌───────────────────────────────────────────────────────┐                          
      │ Gerenciar notas                                       │
      ├────┬──────────────────────────────────────────────────┤
      │  1 │ Adicionar nota para o Aluno (X) no Curso (Y)     │
      ├────┼──────────────────────────────────────────────────┤             
      │  2 │ Edtar nota                                       │    
      ├────┼──────────────────────────────────────────────────┤       
      │  3 │ Excluir nota para o Aluno (X) no Curso (Y)       │       
      ├────┼──────────────────────────────────────────────────┤       
      │  4 │ Exibir média do Aluno (X) no Curso (Y)           │
      ├────┼──────────────────────────────────────────────────┤
      │ 10 │ Voltar                                           │
      └────┴──────────────────────────────────────────────────┘

''');
      opc = stdin.readLineSync()!;
      switch (opc) {
        case '1':
          menuCadastrarNota();
          break;
        case '2':
          menuAlterarNota();
          break;
        case '3':
          menuExcluirNota();
          break;
        case '4':
          menuExibirMedia();
          break;
      }
    }
  }

  menuCadastrarNota() {
    print('\nDigite o código do Aluno a receber a nota: ');
    int codigoAluno = int.parse(stdin.readLineSync()!);
    Aluno? aluno = servico.buscarAlunoPorCodigo(codigoAluno);

    if (aluno != null) {
      print("Digite o código do curso a ser adicionada a nota:");
      int codigoCurso = int.parse(stdin.readLineSync()!);
      Curso? curso = servico.buscarCursoPorCodigo(codigoCurso);

      if (curso != null) {
        print("Digite a nota do aluno:");
        double notaAluno = double.parse(stdin.readLineSync()!);

        servico.cadastrarNota(aluno, curso, notaAluno);
      }
    }
  }

  menuAlterarNota() {}

  menuExcluirNota() {
    print('\nDigite o código do Aluno que a nota será excluída: ');
    int codigoAluno = int.parse(stdin.readLineSync()!);
    Aluno? aluno = servico.buscarAlunoPorCodigo(codigoAluno);

    if (aluno != null) {
      print("Digite o código do curso que a nota será excluída:");
      int codigoCurso = int.parse(stdin.readLineSync()!);
      Curso? curso = servico.buscarCursoPorCodigo(codigoCurso);

      if (curso != null) {
        print("Digite a nota a sex excluída:");
        double notaParaSerExcluida = double.parse(stdin.readLineSync()!);

        servico.excluirNota(aluno, curso, notaParaSerExcluida);
      }
    }
  }

  menuExibirMedia() {
    print('\nDigite o código do Aluno que a média será exibida: ');
    int codigoAluno = int.parse(stdin.readLineSync()!);
    Aluno? aluno = servico.buscarAlunoPorCodigo(codigoAluno);

    if (aluno != null) {
      print("Digite o código do curso que a média será exibida:");
      int codigoCurso = int.parse(stdin.readLineSync()!);
      Curso? curso = servico.buscarCursoPorCodigo(codigoCurso);

      if (curso != null) {
        double media = servico.retornaMedia(aluno, curso);
        print("A média é $media");
      }
    }
  }
}