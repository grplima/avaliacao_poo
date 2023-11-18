import 'pessoa.dart';

class Curso {
  static int codigo = 0;
  int idCurso;
  String nome;
  int totalAlunos;
  List<Pessoa> pessoas;

  Curso(
      {required this.idCurso,
      required this.nome,
      required this.totalAlunos,
      required this.pessoas}) {
    ++codigo;
  }
}
