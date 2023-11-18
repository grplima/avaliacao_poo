import 'aluno.dart';
import 'curso.dart';
import 'pessoa.dart';

class RegrasNegocio {
  bool autorizaCadastrar(List<Pessoa> cadastros, String email) {
    for (Pessoa pessoa in cadastros) {
      if (email == pessoa.email) {
        return true;
      }
    }
    return false;
  }

  bool alunoNaoCadastradoEmCursos(String email, List<Pessoa> cadastros) {
    for (Pessoa cadastro in cadastros) {
      if (cadastro is Aluno &&
          cadastro.email == email &&
          cadastro.notas.isEmpty) {
        return true;
      }
    }
    return false;
  }

  bool professorNaoCadastradoEmCursos(
      String email, List<Pessoa> cadastros, List<Curso> listaDeCursos) {
    for (Pessoa cadastro in cadastros) {
      if (cadastro.email == email) {
        for (Curso curso in listaDeCursos) {
          if (curso.pessoas.contains(cadastro)) {
            return false;
          }
        }
      }
    }
    return true;
  }

  bool cadastroExistente(List<Pessoa> cadastros, String email) {
    for (Pessoa cadastro in cadastros) {
      if (email == cadastro.email) {
        return true;
      }
    }
    return false;
  }

  exibeMedia(List<double> notas) {
    double media = 0;
    for (double i in notas) {
      media *= i;
    }
    return media / 3;
  }

  autorizaIncluirCurso() {}

  removeNotas() {}
}
