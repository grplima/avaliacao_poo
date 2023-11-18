class Utils {
  

  static DateTime converterStringParaDateTime(String dataNascimento) {
    RegExp formatoData = RegExp(r'^\d{2}(/|-|.)?\d{2}(/|-|.)?\d{4}$');

    if (formatoData.hasMatch(dataNascimento)) {
      dataNascimento = dataNascimento
          .replaceAll('/', '')
          .replaceAll('-', '')
          .replaceAll('.', '');
      int dia = int.parse(dataNascimento.substring(0, 2));
      int mes = int.parse(dataNascimento.substring(2, 4));
      int ano = int.parse(dataNascimento.substring(4));

      DateTime dataFormatada = DateTime(ano, mes, dia);
      return dataFormatada;
    } else {
      print('\nData invalida, Tente Novamente');
      return DateTime(0, 0, 0);
    }
  }

  static String converterDateTimeParaString(DateTime dataNascimento) {
    String dataNascimentoString = dataNascimento.toString().replaceAll('-', '');
    String ano = dataNascimentoString.substring(0, 4);
    String mes = dataNascimentoString.substring(4, 6);
    String dia = dataNascimentoString.substring(6, 8);
    return '$dia/$mes/$ano';
  }
}
