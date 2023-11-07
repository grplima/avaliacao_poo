
import 'pessoa.dart';
import 'pessoa_repositorio.dart';

class Servico {

  PessoaRepositorio pessoaRepositorio = PessoaRepositorio();

  bool cadastrarNovaPessoa(Pessoa pessoa){
    Pessoa? pessoaEncontrada = pessoaRepositorio.buscarPorEmail(pessoa.email);
    if(pessoaEncontrada != null){
      pessoaRepositorio.adicionar(pessoa);
      return true;
    }
    return false;
  }

}