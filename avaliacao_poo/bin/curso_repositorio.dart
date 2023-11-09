import 'curso.dart';

class CursoRepositorio {
  List<Curso> listaCursos = [];

  void adicionar(Curso curso) {
    listaCursos.add(curso);
  }

  Curso? buscarPorCodigo(String codigo) {
    for (final curso in listaCursos) {
      if (curso.codigo == codigo) {
        return curso;
      }
    }
    return null;
  }

  void editarCurso(String codigo, Curso novoCurso) {
    final curso = buscarPorCodigo(codigo);
    if (curso != null) {
      listaCursos.remove(curso);
      listaCursos.add(novoCurso);
    }
  }

  void excluirCurso(String codigo) {
    final curso = buscarPorCodigo(codigo);
    if (curso != null) {
      listaCursos.remove(curso);
    }
  }

  List<Curso> listarCursos() {
    return listaCursos;
  }
}
