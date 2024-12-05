class Coffee {
  final String name;
  final String image;
  final int price;
  int quantity;

  Coffee(
      {required this.name,
      required this.image,
      required this.price,
      this.quantity = 1});
}