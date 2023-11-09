class Pessoa {
  int codigo;
  String email;
  String nome;
  DateTime nascimento;

  Pessoa({
    required this.codigo,
    required this.email,
    required this.nome,
    required this.nascimento, String? endereco,
  });

  get endereco => null;
}

// Exemplo de uso:
final pessoa = Pessoa(
  codigo: 1,
  email: 'email@example.com',
  nome: 'Nome da Pessoa',
  nascimento: DateTime(2000, 1, 1),
);
