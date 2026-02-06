class FoodModel {
  final int id;
  final String name;
  final int price;
  final String description;
  final String image;

  FoodModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      name: json['title'],
      price: json['price'],
      description: json['description'],
      image: (json['images'] != null && json['images'].isNotEmpty)
          ? json['images'][0]
          : 'https://via.placeholder.com/300',
    );
  }
}
