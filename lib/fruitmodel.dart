class Welcome {
  String name;
  int id;
  String family;
  String order;
  String genus;
  Nutritions nutritions;

  Welcome({
    required this.name,
    required this.id,
    required this.family,
    required this.order,
    required this.genus,
    required this.nutritions,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) {
    return Welcome(
      name: json['name'],
      id: json['id'],
      family: json['family'],
      order: json['order'],
      genus: json['genus'],
      nutritions: Nutritions.fromJson(json['nutritions']),
    );
  }
}

class Nutritions {
  int calories;
  double fat;
  double sugar;
  double carbohydrates;
  double protein;

  Nutritions({
    required this.calories,
    required this.fat,
    required this.sugar,
    required this.carbohydrates,
    required this.protein,
  });

  factory Nutritions.fromJson(Map<String, dynamic> json) {
    return Nutritions(
      calories: json['calories'],
      fat: json['fat'].toDouble(),
      sugar: json['sugar'].toDouble(),
      carbohydrates: json['carbohydrates'].toDouble(),
      protein: json['protein'].toDouble(),
    );
  }
}
