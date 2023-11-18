import 'pessoa.dart';

class Professor extends Pessoa {
  double salario;

  Professor({
    required super.registro,
    required super.email,
    required super.nome,
    required super.nascimento,
    super.endereco,
    required this.salario,
  }) {
    ++Pessoa.codigo;
  }
}
