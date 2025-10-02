import '../../Domain/entitiy/post.dart';

class Postmodel extends Post {
  const Postmodel({int? id, required super.title, required super.body})
    : super(id: 0);
  factory Postmodel.fromJson(Map<String, dynamic> json) {
    return Postmodel(id: json['id'], title: json['title'], body: json['body']);
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'body': body};
  }
}
