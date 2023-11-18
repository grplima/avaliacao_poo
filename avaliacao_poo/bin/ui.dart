import 'dart:io';
import 'aluno.dart';
import 'curso.dart';
import 'nota_aluno.dart';
import 'pessoa.dart';
import 'professor.dart';
import 'regrasnegocio.dart';
import 'repositorio.dart';
import 'utils.dart';

class Ui {
  Repositorios repo = Repositorios();
  RegrasNegocio rn = RegrasNegocio();

String exibeMenuPrincipal(String objEscolhido) {
    print('''

      ╔════════════════════════════════╗
      ║         MENU PRINCIPAL         ║
      ╠════╦═══════════════════════════╣
      ║ 1  ║  ALUNO                    ║
      ║════╬═══════════════════════════╣           
      ║ 2  ║  PROFESSOR                ║           
      ║════╬═══════════════════════════╣         
      ║ 3  ║  CURSOS                   ║     
      ║════╬═══════════════════════════╣           
      ║ 10 ║  FINALIZAR                ║           
      ╚════╩═══════════════════════════╝
        
        ''');
    objEscolhido = stdin.readLineSync()!.toLowerCase();
    return objEscolhido;
  }

  menuPrincipal() {
    String opcaoMenu = '';
    while (opcaoMenu != 'sair') {
      opcaoMenu = exibeMenuPrincipal(opcaoMenu);
      if (opcaoMenu == '10') {
        break;
      }
      switch (opcaoMenu) {
        case '1':
          String acao = menuServicosPessoa();
          switch (acao) {
            case '1':
              Aluno aluno = criarAluno();
              repo.cadastrarPessoa(aluno);
              break;
            case '2':
              String identificador = pedeIdentificador();
              if (rn.cadastroExistente(repo.cadastros, identificador)) {
                repo.alterarAluno(identificador);
                print('Alteração realizada');
              } else {
                print('Aluno não localizado');
              }
              break;
            case '3':
              String email = pedeIdentificador();
              if (rn.cadastroExistente(repo.cadastros, email)) {
                if (rn.alunoNaoCadastradoEmCursos(email, repo.cadastros)) {
                  repo.excluirAluno(email);
                } else {
                  print('Aluno cadastrado em curso(s), não é possivel excluir');
                }
              } else {
                print('Cadastro não localizado na lista de Alunos');
              }
              break;
            case '4':
              repo.listarAlunos();
              break;
            default:
              print('Opção inválida');
              break;
          }
          break;
        case '2':
          String acao = menuServicosPessoa();
          switch (acao) {
            case '1':
              Professor professor = criarProfessor();
              repo.cadastrarPessoa(professor);
              break;
            case '2':
              String identificador = pedeIdentificador();
              if (rn.cadastroExistente(repo.cadastros, identificador)) {
                repo.alterarProfessor(identificador);
                print('Alteração realizada');
              } else {
                print('Professor não localizado');
              }
              break;
            case '3':
              String email = pedeIdentificador();
              if (rn.cadastroExistente(repo.cadastros, email)) {
                if (rn.professorNaoCadastradoEmCursos(
                    email, repo.cadastros, repo.listaDeCursos)) {
                  repo.excluirProfessor(email);
                } else {
                  print(
                      'Professor cadastrado em curso(s), não é possivel excluir');
                }
              } else {
                print('Cadastro não localizado na lista de Professores');
              }
              break;
            case '4':
              repo.listarProfessores();
              break;
            default:
              print('Opção inválida');
              break;
          }
          break;
        case '3':
          String acao = menuServicosCurso();
          switch (acao) {
            case '1':
              Curso curso = criarCurso();
              repo.cadastrarCurso(curso);
              print('Curso cadastrado');
              break;
            case '2':
              String nomeCurso = identificadorCurso();
              if (repo.cursoExistente(nomeCurso)) {
                String acao = pedeAlteracaoCurso();
                Curso curso = repo.buscaCursoEmListaDeCursos(nomeCurso);
                switch (acao) {
                  case '1':
                    alteraNomeCurso(curso);
                    break;
                  case '2':
                    alteraLimiteAlunos(curso);
                    break;
                  default:
                    print('Opção inválida');
                    break;
                }
              }
            case '3':
              String nomeCurso = identificadorCurso();
              if (repo.cursoExistente(nomeCurso)) {
                Curso curso = repo.buscaCursoEmListaDeCursos(nomeCurso);
                if (repo.cursoSemPessoasCadastradas(curso)) {
                  repo.excluirCurso(curso);
                } else {
                  print(
                      '\nO curso tem pessoas cadastradas!\nUm curso não pode ser excluído com pessoas cadastradas!');
                }
              } else {
                print('Curso não encontrado');
              }
              break;
            case '4':
              repo.listarCursos();
              break;
            case '5':
              String nomeCurso = identificadorCurso();
              String alunoOuProfessor = menuAlunoOuProfessor();
              switch (alunoOuProfessor) {
                case '1':
                  String opAlteraCurso = pedeAlteracaoCursoAluno(nomeCurso);
                  switch (opAlteraCurso) {
                    case '1':
                      print('\nInforme o email do aluno a ser cadastrado:');     /// BUSCA PELO CODIGO DO ALUNO PARA CADASTRO NO CURSO
                      String email = stdin.readLineSync()!;
                      if (rn.cadastroExistente(repo.cadastros, email)) {
                        if (repo.cursoExistente(nomeCurso)) {
                          Aluno aluno = repo.buscaPessoaEmCadastros(email);
                          Curso curso =
                              repo.buscaCursoEmListaDeCursos(nomeCurso);
                          if (repo.verificaSeAlunoEstaCadastradoNoCurso(
                              curso, aluno)) {
                            print('Aluno já cadastrado no curso');
                          } else {
                            repo.incluirAlunoCurso(curso, aluno);
                          }
                        } else {
                          print('\nCurso não localizado');
                        }
                      } else {
                        print('\nE-mail não localizado na lista de Aluno');
                      }
                    case '2':
                      //Remoção de Aluno do curso
                      print('\nInforme o email do aluno a ser removido:');
                      String email = stdin.readLineSync()!;
                      if (rn.cadastroExistente(repo.cadastros, email)) {
                        if (repo.cursoExistente(nomeCurso)) {
                          Aluno aluno = repo.buscaPessoaEmCadastros(email);
                          Curso curso =
                              repo.buscaCursoEmListaDeCursos(nomeCurso);
                          if (repo.verificaSeAlunoEstaCadastradoNoCurso(
                              curso, aluno)) {
                            repo.removerAlunoDoCurso(curso, aluno);
                          } else {
                            print('Aluno não cadastrado no curso');
                          }
                        } else {
                          print('Curso não localizado');
                        }
                      } else {
                        print('Cadastro não localizado');
                      }
                    case '3':
                      //Listar Alunos
                      Curso curso = repo.buscaCursoEmListaDeCursos(nomeCurso);
                      repo.listarAlunosCurso(curso);
                    case '4':
                      print(
                          '\nInforme o email do aluno que deseja gerenciar as notas:');
                      String email = stdin.readLineSync()!;
                      if (rn.cadastroExistente(repo.cadastros, email)) {
                        if (repo.cursoExistente(nomeCurso)) {
                          Aluno aluno = repo.buscaPessoaEmCadastros(email);
                          Curso curso =
                              repo.buscaCursoEmListaDeCursos(nomeCurso);
                          if (repo.verificaSeAlunoEstaCadastradoNoCurso(
                              curso, aluno)) {
                            String acaoNota = menuGerenciarNotas();
                            List<double> notas = repo
                                .buscaListaDeNotasDoAlunoNoCurso(aluno, curso);
                            switch (acaoNota) {
                              case '1':
                                lancarNotas(notas);
                                break;
                              case '2':
                                if (notas.isNotEmpty) {
                                  alterarNotas(notas);
                                  break;
                                } else {
                                  print('Aluno não tem notas lançadas');
                                  break;
                                }
                              case '3':
                                if (notas.isNotEmpty) {
                                  excluirNotas(notas);
                                  break;
                                } else {
                                  print('Aluno não tem notas lançadas');
                                  break;
                                }
                              case '4':
                                if (notas.isNotEmpty) {
                                  exibirNotas(notas);
                                  break;
                                } else {
                                  print('Aluno não tem notas lançadas');
                                  break;
                                }
                              case '5':
                                if (notas.isNotEmpty) {
                                  exibirMedia(notas);
                                  break;
                                } else {
                                  print('Aluno não tem notas lançadas');
                                  break;
                                }

                              default:
                                print('Ação inválida');
                            }
                          } else {
                            print('Aluno não cadastrado no curso');
                          }
                        } else {
                          print('\nCurso não localizado');
                        }
                      } else {
                        print('\nE-mail não localizado na lista de Aluno');
                      }
                  }
                case '2':
                  String opAlteraCurso = pedeAlteracaoCursoProfessor(nomeCurso);
                  switch (opAlteraCurso) {
                    case '1':
                      //Inclusão de Professor no curso
                      print('\nInforme o email do professor a ser cadastrado:');
                      String email = stdin.readLineSync()!;
                      if (rn.cadastroExistente(repo.cadastros, email)) {
                        if (repo.cursoExistente(nomeCurso)) {
                          Professor professor =
                              repo.buscaPessoaEmCadastros(email);
                          Curso curso =
                              repo.buscaCursoEmListaDeCursos(nomeCurso);
                          repo.incluirProfessorCurso(curso, professor);
                        } else {
                          print('\nCurso não localizado');
                        }
                      } else {
                        print(
                            '\nE-mail não localizado na lista de Professores');
                      }
                    case '2':
                      //Remoção de Professor do curso
                      print('\nInforme o email do Professor a ser removido:');
                      String email = stdin.readLineSync()!;
                      if (rn.cadastroExistente(repo.cadastros, email)) {
                        if (repo.cursoExistente(nomeCurso)) {
                          Professor professor =
                              repo.buscaPessoaEmCadastros(email);
                          Curso curso =
                              repo.buscaCursoEmListaDeCursos(nomeCurso);
                          if (repo.verificaSeProfessorEstaCadastradoNoCurso(
                              curso, professor)) {
                            repo.removerProfessorDoCurso(curso, professor);
                          } else {
                            print('Professor não cadastrado no curso');
                          }
                        } else {
                          print('Curso não localizado');
                        }
                      } else {
                        print('Cadastro não localizado');
                      }

                    case '3':
                      //Listar professores.
                      Curso curso = repo.buscaCursoEmListaDeCursos(nomeCurso);
                      repo.listarProfessoresCurso(curso);
                  }
              }
              break;
            default:
              print('Opção inválida');
              break;
          }
          break;
        case '0':
          opcaoMenu = 'sair';
          break;
        default:
          print('Opção inválida, tente novamente.');
      }
    }
  }

  

  String menuServicosPessoa() {
    print('''

      ┌────────────────────────────────┐
      │    MENU USUARIO                │                                     
      ├────┬───────────────────────────┤
      │ 1  │  Novo usuário             │
      ├────┼───────────────────────────┤
      │ 2  │  Editar um usuário        │ 
      ├────┼───────────────────────────┤
      │ 3  │  Excluir um usuário       │
      ├────┼───────────────────────────┤
      │ 4  │  Listar todos os usuários │
      ├────┼───────────────────────────┤
      │ 10 │  Voltar ao menu anterior  │ 
      └────┴───────────────────────────┘

''');
    String opcServicos = stdin.readLineSync()!;
    return opcServicos;
  }

  String menuServicosCurso() {
    print('''

      ┌────────────────────────────────┐
      │    MENU CURSOS                 │                                     
      ├────┬───────────────────────────┤
      │ 1  │  Criar um curso           │
      ├────┼───────────────────────────┤
      │ 2  │  Alterar um curso         │ 
      ├────┼───────────────────────────┤
      │ 3  │  Excluir um curso         │
      ├────┼───────────────────────────┤
      │ 4  │  Listar todos os cursos   │
      ├────┼───────────────────────────┤
      │ 5  │  Gerenciar um curso       │
      ├────┼───────────────────────────┤
      │ 10 │  Voltar ao menu anterior  │ 
      └────┴───────────────────────────┘
      
''');
    String opcServicos = stdin.readLineSync()!;
    return opcServicos;
  }

  Aluno criarAluno() {
    String nomeAluno = '';
    String dataNascimentoStr = '';
    String email = 'invalido';
    String? endereco;
    int registro = Pessoa.codigo;
    List<NotaAluno> notas = [];

    while (email == 'invalido') {
      print('\nInforme o e-mail: ');
      email = stdin.readLineSync()!;
      if (rn.autorizaCadastrar(repo.cadastros, email)) {
        print('E-mail já cadastrado');
        email = 'invalido';
      } else {
        break;
      }
    }

    print('\nInforme o nome: ');
    nomeAluno = stdin.readLineSync()!;

    DateTime dataNascimentoDateTime = DateTime(0, 0, 0);
    while (dataNascimentoDateTime == DateTime(0, 0, 0)) {
      print('\nInforme o data de nascimento: ');
      dataNascimentoStr = stdin.readLineSync()!;
      dataNascimentoDateTime =
          Utils.converterStringParaDateTime(dataNascimentoStr);
    }
    print('\nInforme o endereço: ');
    endereco = stdin.readLineSync()!;
    Aluno aluno = Aluno(
        registro: registro,
        email: email,
        nome: nomeAluno,
        nascimento: dataNascimentoDateTime,
        endereco: endereco,
        notas: notas);
    return aluno;
  }

  Professor criarProfessor() {
    String nomeProfessor = '';
    String dataNascimentoStr = '';
    String email = 'invalido';
    String? endereco;
    int registro = Pessoa.codigo;

    while (email == 'invalido') {
      print('\nInforme o e-mail: ');
      email = stdin.readLineSync()!;
      if (rn.autorizaCadastrar(repo.cadastros, email)) {
        print('E-mail já cadastrado');
        email = 'invalido';
      } else {
        break;
      }
    }

    print('\nInforme o nome: ');
    nomeProfessor = stdin.readLineSync()!;

    DateTime dataNascimentoDateTime = DateTime(0, 0, 0);
    while (dataNascimentoDateTime == DateTime(0, 0, 0)) {
      print('\nInforme o data de nascimento: ');
      dataNascimentoStr = stdin.readLineSync()!;
      dataNascimentoDateTime =
          Utils.converterStringParaDateTime(dataNascimentoStr);
    }
    print('\nInforme o endereço: ');
    endereco = stdin.readLineSync()!;

    double salario = solicitaSalario();

    Professor professor = Professor(
        registro: registro,
        email: email,
        nome: nomeProfessor,
        nascimento: dataNascimentoDateTime,
        endereco: endereco,
        salario: salario);
    return professor;
  }

  double solicitaSalario() {
    print('\nInforme o salário do professor: ');
    double salario = double.parse(stdin.readLineSync()!);
    return salario;
  }

  String pedeIdentificador() {
    print('\nInforme o e-mail cadastrado:');
    String email = stdin.readLineSync()!;
    return email;
  }

  String identificadorCurso() {
    String nome = '';
    do {
      print('\nInforme o nome do curso:');
      nome = stdin.readLineSync()!;
      if (repo.cursoExistente(nome) == false) {
        print('Curso não localizado');
      }
    } while (repo.cursoExistente(nome) == false);

    return nome;
  }

  Curso criarCurso() {
    String nome = '';
    int totalAlunos = 0;
    List<Pessoa> alunosDoCurso = [];
    int idCurso = Curso.codigo;

    do {
      print('\nInforme o nome do curso: ');
      nome = stdin.readLineSync()!;
      if (repo.cursoExistente(nome)) {
        print('Curso já existe');
      }
    } while (repo.cursoExistente(nome));

    do {
      print('\nInforme o total de alunos: ');
      totalAlunos = int.parse(stdin.readLineSync()!);
      if (totalAlunos <= 0) {
        print('Não é possível criar um limite menor que 1');
      }
    } while (totalAlunos <= 0);

    Curso curso = Curso(
        nome: nome,
        totalAlunos: totalAlunos,
        idCurso: idCurso,
        pessoas: alunosDoCurso);
    return curso;
  }

  String pedeAlteracaoCursoAluno(String nomeCurso) {
    print(
        '\nQual alteração você deseja realizar no curso $nomeCurso?\n1 - Cadastrar\n2 - Remover\n3 - Listar\n4 - Gerenciar notas');
    String opAlteraCurso = stdin.readLineSync()!;
    return opAlteraCurso;
  }

  String menuGerenciarNotas() {
    print(
        '\nQual ação deseja realizar?\n1 - Lançar notas\n2 - Alterar notas\n3 - Excluir notas\n4 - Exibir notas\n5 - Exibir Média Aritimética');
    String opAlteraCurso = stdin.readLineSync()!;
    return opAlteraCurso;
  }

  String pedeAlteracaoCursoProfessor(String nomeCurso) {
    print(
        '\nQual alteração você deseja realizar no curso $nomeCurso?\n1 - Cadastrar\n2 - Remover\n3 - Listar');
    String opAlteraCurso = stdin.readLineSync()!;
    return opAlteraCurso;
  }

  String informaPessoaRemoverCurso(bool id) {
    if (id == true) {
      print('\nInforme o email do aluno a ser removido:');
      String email = stdin.readLineSync()!;
      return email;
    } else {
      print('\nInforme o email do Professor a ser removido:');
      String email = stdin.readLineSync()!;
      return email;
    }
  }

  menuAlunoOuProfessor() {
    print('\nVocê deseja realizar está ação para:\n1 - Aluno\n2 - Professor');
    String alunoOuProfessor = stdin.readLineSync()!;
    return alunoOuProfessor;
  }

  String gerenciarNotas() {
    print('\nVocê deseja:\n1 - Lançar notas\n2 - Exibir notas');
    String opcNotas = stdin.readLineSync()!;
    return opcNotas;
  }

  double coletarNota() {
    print('Informe a nota do aluno:');
    double nota = double.parse(stdin.readLineSync()!);
    return nota;
  }

  String pedeAlteracaoCurso() {
    print(
        '\nQual alteração deseja realizar:\n1 - Alterar nome\n2 - Alterar limite de alunos');
    String acao = stdin.readLineSync()!;
    return acao;
  }

  alteraNomeCurso(Curso curso) {
    String novoNome = '';
    while (novoNome == '') {
      print('\nInforme o novo nome:');
      novoNome = stdin.readLineSync()!;
    }
    curso.nome = novoNome;
    print('Nome Alterado');
  }

  alteraLimiteAlunos(Curso curso) {
    int novoLimiteDeAlunos = 0;
    while (novoLimiteDeAlunos <= 0) {
      print('\nInforme o novo limite:');
      novoLimiteDeAlunos = int.parse(stdin.readLineSync()!);
    }
    curso.totalAlunos = novoLimiteDeAlunos;
    print('Limite alterado');
  }

  bool verificaSeLimiteDeNotasFoiAtingido(List<double> notas) {
    if (notas.length < 3) {
      return false;
    }
    return true;
  }

  lancarNotas(List<double> notas) {
    while (verificaSeLimiteDeNotasFoiAtingido(notas) == false) {
      double nota = 0;
      while (nota <= 0) {
        print('Informe uma nota:');
        nota = double.parse(stdin.readLineSync()!);
      }
      notas.add(nota);
    }
    print('Limite de notas atingido');
  }

  alterarNotas(List<double> notas) {
    if (notas.isNotEmpty) {
      exibirNotas(notas);
    }
    String notaEscolhida = '';
    if (notas.length == 1) {
      print('Qual nota deseja alterar?\n1 - Nota 1');
      notaEscolhida = stdin.readLineSync()!;
    } else if (notas.length == 2) {
      print('Qual nota deseja alterar?\n1 - Nota 1\n2 - Nota 2');
      notaEscolhida = stdin.readLineSync()!;
    } else if (notas.length == 3) {
      print('Qual nota deseja alterar?\n1 - Nota 1\n2 - Nota 2\n3 - Nota 3');
      notaEscolhida = stdin.readLineSync()!;
    }

    double notaNova = 0;
    while (notaNova <= 0) {
      print('Informe uma nota:');
      notaNova = double.parse(stdin.readLineSync()!);
    }

    switch (notaEscolhida) {
      case '1':
        notas[0] = notaNova;
        print('Nota alterada');
        break;
      case '2':
        notas[1] = notaNova;
        print('Nota alterada');
        break;
      case '3':
        notas[2] = notaNova;
        print('Nota alterada');
        break;
      default:
        print('Opção invalida');
        break;
    }
  }

  excluirNotas(List<double> notas) {
    if (notas.isNotEmpty) {
      exibirNotas(notas);
    }
    String notaEscolhida = '';
    if (notas.length == 1) {
      print('Qual a nota deseja excluir?\n1 - Nota 1');
      notaEscolhida = stdin.readLineSync()!;
    } else if (notas.length == 2) {
      print('Qual a nota deseja excluir?\n1 - Nota 1\n2 - Nota 2');
      notaEscolhida = stdin.readLineSync()!;
    } else if (notas.length == 3) {
      print('Qual a nota deseja excluir?\n1 - Nota 1\n2 - Nota 2\n3 - Nota 3');
      notaEscolhida = stdin.readLineSync()!;
    }

    switch (notaEscolhida) {
      case '1':
        notas.remove(notas[0]);
        print('Nota removida');
        break;
      case '2':
        notas.remove(notas[1]);
        print('Nota removida');
        break;
      case '3':
        notas.remove(notas[2]);
        print('Nota removida');
        break;
      default:
        print('Opção invalida');
        break;
    }
  }

  exibirNotas(List<double> notas) {
    print('O aluno possui ${notas.length} nota(s) registrada(s):');
    for (double nota in notas) {
      print('Nota ${notas.indexOf(nota) + 1}: $nota');
    }
  }

  exibirMedia(List<double> notas) {
    double somaDasNotas = 0;
    int qtdDeNotas = 0;
    for (double nota in notas) {
      somaDasNotas += nota;
      qtdDeNotas++;
    }
    double media = somaDasNotas / qtdDeNotas;
    print('A média aritimética é ${media.toStringAsFixed(2)}');
  }
}
