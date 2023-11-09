import 'aluno.dart';

class AlunoRepositorio {
  List<Aluno> listaAlunos = [];

  void adicionar(Aluno aluno) {
    listaAlunos.add(aluno);
  }

  Aluno? buscarPorCodigo(String codigo) {
    for (final aluno in listaAlunos) {
      if (aluno.codigo == codigo) {
        return aluno;
      }
    }
    return null;
  }

  void editarAluno(String codigo, Aluno novoAluno) {
    final aluno = buscarPorCodigo(codigo);
    if (aluno != null) {
      listaAlunos.remove(aluno);
      listaAlunos.add(novoAluno);
    }
  }

  void excluirAluno(String codigo) {
    final aluno = buscarPorCodigo(codigo);
    if (aluno != null) {
      listaAlunos.remove(aluno);
    }
  }

  List<Aluno> listarAlunos() {
    return listaAlunos;
  }
}
