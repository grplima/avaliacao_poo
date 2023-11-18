import 'nota_aluno.dart';
import 'pessoa.dart';

class Aluno extends Pessoa {
  List<NotaAluno> notas = [];

  Aluno({
    required super.registro,
    required super.email,
    required super.nome,
    required super.nascimento,
    super.endereco,
    required this.notas,
  }) {
    ++Pessoa.codigo;
  }
}
