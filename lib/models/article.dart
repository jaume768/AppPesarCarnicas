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
  bool isMarket;
  bool isAccepted;
  double _weight;

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
    this.isMarket = false,
    this.isAccepted = false,
    double weight = 0.0,
  }) : _weight = weight;

  double get weight => _weight;

  set weight(double value) {
    _weight = value;
  }

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
      isMarket: json['isMarket'],
      isAccepted: json['isAccepted'],
      weight: json['weight']?.toDouble() ?? 0.0,
    );
  }
}
