import 'pessoa.dart';

class Curso {
  int codigo;
  String nome;
  int totalAlunos;
  List<Pessoa> pessoas = [];

  Curso(this.codigo, this.nome, this.totalAlunos);
}
