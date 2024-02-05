class Pedido {
  String nome;
  bool viagem;
  List<String> lanches;
  String observacao;
  List<String> bebidas;
  String valor;

  Pedido({
    required this.nome,
    required this.viagem,
    required this.lanches,
    required this.observacao,
    required this.bebidas,
    required this.valor,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'viagem': viagem,
      'lanches': lanches,
      'observacao': observacao,
      'bebidas': bebidas,
      'valor': valor,
    };
  }
}
