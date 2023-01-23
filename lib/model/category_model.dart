class CategoryModel {
  late final String category;
  late final String data;

  CategoryModel({required this.category, required this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    data = json['data'];
  }
}
