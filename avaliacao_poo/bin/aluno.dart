import 'pessoa.dart';

class Aluno extends Pessoa{
  late List notas = [];

  Aluno({required super.codigo, required super.email, required super.nome, required super.nascimento,});
  
}