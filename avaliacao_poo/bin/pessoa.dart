class Pessoa {
  static int codigo = 1;
  String email;
  String nome;
  DateTime nascimento;
  String? endereco;
  int registro;

  Pessoa(
      {required this.email,
      required this.registro,
      required this.nome,
      required this.nascimento,
      this.endereco = ''});

}
