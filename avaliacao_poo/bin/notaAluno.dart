class NotaAluno {
  List<double> notas = [];

  void adicionarNota(double nota) {
    if (notas.length < 3) {
      notas.add(nota);
    }
  }

  void alterarNota(int indice, double novaNota) {
    if (indice >= 0 && indice < notas.length) {
      notas[indice] = novaNota;
    }
  }

  void excluirNota(int indice) {
    if (indice >= 0 && indice < notas.length) {
      notas.removeAt(indice);
    }
  }

  double calcularMedia() {
    if (notas.isNotEmpty) {
      return notas.reduce((a, b) => a + b) / notas.length;
    } else {
      return 0.0;
    }
  }
}
