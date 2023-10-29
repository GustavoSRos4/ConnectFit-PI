dateFormat(data) {
  String getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return "Segunda";
      case 2:
        return 'Terça';
      case 3:
        return 'Quarta';
      case 4:
        return 'Quinta';
      case 5:
        return 'Sexta';
      case 6:
        return 'Sabado';
      case 7:
        return 'Domingo';
      default:
        throw ArgumentError('Mês inválido: $weekday');
    }
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Janeiro';
      case 2:
        return 'Fevereiro';
      case 3:
        return 'Março';
      case 4:
        return 'Abril';
      case 5:
        return 'Maio';
      case 6:
        return 'Junho';
      case 7:
        return 'Julho';
      case 8:
        return 'Agosto';
      case 9:
        return 'Setembro';
      case 10:
        return 'Outubro';
      case 11:
        return 'Novembro';
      case 12:
        return 'Dezembro';
      default:
        throw ArgumentError('Mês inválido: $month');
    }
  }

  return "${getDayName(data.weekday)}, ${data.day} de ${getMonthName(data.month)}";
}
