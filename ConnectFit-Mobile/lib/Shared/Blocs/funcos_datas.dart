import 'package:intl/intl.dart';

class CalcularIdade {
  static int calcularIdade(String stringBirthDate) {
    DateTime birthDate = DateFormat("yyyy-MM-dd").parse(stringBirthDate);

    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }
}

class FormatarDatas {
  static String formatarData(String dataRecebida) {
    String dataOriginal = dataRecebida;
    DateTime data = DateTime.parse(dataOriginal);

    String dataFormatada = DateFormat('dd/MM/yyyy').format(data);

    return dataFormatada;
  }
}

class CalculosDatas {
  static bool checarDataisNull(String? dataRecebida) {
    if (dataRecebida == null || dataRecebida.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
