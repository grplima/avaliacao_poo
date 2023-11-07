import 'pessoa.dart';

class Professor extends Pessoa{
  late double salario;

  Professor({required super.codigo, required super.email, required super.nome, required super.nascimento});
}