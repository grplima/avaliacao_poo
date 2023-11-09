import 'pessoa.dart';

class PessoaRepositorio {
  List<Pessoa> listaPessoas = [];

  void adicionar(Pessoa pessoa) {
    listaPessoas.add(pessoa);
  }

  Pessoa? buscarPorEmail(String email) {
    for (final pessoa in listaPessoas) {
      if (pessoa.email == email) {
        return pessoa;
      }
    }
    return null;
  }

  List<Pessoa> listarPessoas() {
    return listaPessoas;
  }
}
