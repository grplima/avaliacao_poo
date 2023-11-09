import 'pessoa.dart';

class Aluno extends Pessoa {

  late List notas = [];

  final int codigo;
  final String email;
  final String nome;
  final DateTime nascimento;

  Aluno({
    required this.codigo,
    required this.email,
    required this.nome,
    required this.nascimento,
  }) : super(codigo: 0, email: '', nome: '', nascimento: '00/00/0000' as DateTime);
}
