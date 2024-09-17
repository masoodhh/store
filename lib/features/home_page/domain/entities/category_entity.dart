class CategoryEntity {
  final int id;
  final String title;
  bool isChecked;

  CategoryEntity({required this.id, required this.title, this.isChecked = false});

}