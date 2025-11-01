class Restaurant {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final List<String> categories;
  final int deliveryTimeMin;
  final double deliveryFee;

  Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.categories,
    required this.deliveryTimeMin,
    required this.deliveryFee,
  });
}
