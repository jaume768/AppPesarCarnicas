class Article {
  final int id;
  final int code;
  final String name;
  final String observation;
  final double units;
  final String unitType;
  final bool special;
  final bool mandatoryLot;
  final dynamic primaryAction;
  final dynamic secondaryAction;

  Article({
    required this.id,
    required this.code,
    required this.name,
    required this.observation,
    required this.units,
    required this.unitType,
    required this.special,
    required this.mandatoryLot,
    this.primaryAction,
    this.secondaryAction,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      observation: json['observation'],
      units: json['units'].toDouble(),
      unitType: json['unitType'],
      special: json['special'],
      mandatoryLot: json['mandatoryLot'],
      primaryAction: json['primaryAction'],
      secondaryAction: json['secondaryAction'],
    );
  }
}