class ScanModel {
  int greeting;
  String tipo;
  String valor;

  ScanModel({
    this.greeting,
    this.tipo,
    this.valor,
  }) {
    if (this.valor.contains('https')) {
      this.tipo = 'https';
    } else {
      this.tipo = 'geo';
    }
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        greeting: json["greeting"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "greeting": greeting,
        "tipo": tipo,
        "valor": valor,
      };
}
