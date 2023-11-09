
import 'curso.dart';
import 'curso_repositorio.dart';
import 'pessoa.dart';
import 'pessoa_repositorio.dart';

class Servico {

  int codigoPessoa = 0;
  int codigoCurso = 0;
  List<Pessoa> listapessoas = [];

  PessoaRepositorio pessoaRepositorio = PessoaRepositorio();
  CursoRepositorio cursoRepositorio = CursoRepositorio();

  bool cadastrarNovaPessoa(Pessoa pessoa){
    Pessoa? pessoaEncontrada = pessoaRepositorio.buscarPorEmail(pessoa.email);
    if(pessoaEncontrada == null){
      pessoaRepositorio.adicionar(pessoa);
      return true;
    }
    return false;
  }

  cadastrarNovoCurso(Curso curso){
    cursoRepositorio.adicionarCurso(curso);
  }

}