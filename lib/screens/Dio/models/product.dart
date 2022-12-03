class Prouct {
  const Prouct({
    required this.id,
    required this.title,
    required this.description,
  });

  final int id;
  final String title;
  final String description;

  factory Prouct.fromJson(Map<String, dynamic> data) {
    final id = data["id"] as int?;
    final title = data["title"] as String?;
    final description = data["description"] as String?;

    return Prouct(
      id: id ?? 0,
      title: title ?? "",
      description: description ?? "",
    );
  }
}
