class PostModel {
  final dynamic id;
  final String? title;
  final String? content;
  final String? slug;
  final int? status;
  final String? category;
  final String? image;
  final String? createdAt;

  PostModel({
    this.id,
    this.title,
    this.content,
    this.slug,
    this.status,
    this.category,
    this.image,
    this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> jsonData) {
    return PostModel(
      id: jsonData['id'],
      title: jsonData['title'],
      content: jsonData['content'],
      slug: jsonData['slug'],
      status: jsonData['status_code'],
      category: jsonData['category'],
      image: jsonData['image'],
      createdAt: jsonData['created_at'],
    );
  }

  Null get status_code => null;
}

class PostListModel {
  final int? status; // 200 - 204 - 400 - 404
  final List<PostModel>? items;
  PostListModel({this.status, this.items});
  factory PostListModel.fromJson(Map<String, dynamic> jsonData) {
    return PostListModel(
      status: jsonData['status'],
      items: jsonData['items'] != null
          ? List<PostModel>.from(
              jsonData['items'].map((data) => PostModel.fromJson(data)),
            )
          : [],
    );
  }
}
