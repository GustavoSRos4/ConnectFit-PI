class MedidasModel {
  final String? peso;
  final String? percentual;
  final String? subescapular;
  final String? triceps;
  final String? peitoral;
  final String? axilarMedia;
  final String? supraIliaca;
  final String? abdominal;
  final String? femuralMedia;

  MedidasModel({
    this.peso,
    this.percentual,
    this.subescapular,
    this.triceps,
    this.peitoral,
    this.axilarMedia,
    this.supraIliaca,
    this.abdominal,
    this.femuralMedia,
  });

  MedidasModel copyWith({
    String? peso,
    String? percentual,
    String? subescapular,
    String? triceps,
    String? peitoral,
    String? axilarMedia,
    String? supraIliaca,
    String? abdominal,
    String? femuralMedia,
  }) {
    return MedidasModel(
      peso: peso ?? this.peso,
      percentual: percentual ?? this.percentual,
      subescapular: subescapular ?? this.subescapular,
      triceps: triceps ?? this.triceps,
      peitoral: peitoral ?? this.peitoral,
      axilarMedia: axilarMedia ?? this.axilarMedia,
      supraIliaca: supraIliaca ?? this.supraIliaca,
      abdominal: abdominal ?? this.abdominal,
      femuralMedia: femuralMedia ?? this.femuralMedia,
    );
  }

  @override
  String toString() => """MedidasModel(
      peso: $peso 
      percentual: $percentual
      subescapular: $subescapular 
      triceps: $triceps 
      peitoral: $peitoral 
      axilarMedia: $axilarMedia 
      supraIliaca: $supraIliaca 
      abdominal: $abdominal 
      femuralMedia: $femuralMedia 
      )""";
}
