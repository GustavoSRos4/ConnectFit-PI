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
