import 'curso_repositorio.dart';
import 'pessoa.dart';

class Servico {
  List<Pessoa> listaPessoas = [];
  int codigoCurso = 0;

  bool cadastrarNovaPessoa(Pessoa pessoa) {
    if (listaPessoas.any((p) => p.email == pessoa.email)) {
      print("E-mail já cadastrado.");
      return false;
    }

    listaPessoas.add(pessoa);
    return true;
  }

  List<Pessoa> listarPessoas() {
    return listaPessoas;
  }

  bool editarCadastro(Pessoa pessoa) {
    final index = listaPessoas.indexWhere((p) => p.codigo == pessoa.codigo);
    if (index != -1) {
      listaPessoas[index] = pessoa;
      return true;
    }
    return false;
  }

  bool excluirCadastro(int codigo) {
    final index = listaPessoas.indexWhere((p) => p.codigo == codigo);
    if (index != -1) {
      listaPessoas.removeAt(index);
      return true;
    }
    return false;
  }

  cadastrarNovoCurso() {
    CursoRepositorio.listaCursos.add(curso);
  }
}
