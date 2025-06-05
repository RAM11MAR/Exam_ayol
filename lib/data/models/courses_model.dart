import 'package:json_annotation/json_annotation.dart';

part 'courses_model.g.dart';

@JsonSerializable(createToJson: false)
class CoursesModel {
  final int id;
  final String user;
  final String category;
  final String image;
  final String title;
  final num price;
  final num rating;
  final String? status;

  CoursesModel({
    required this.id,
    required this.user,
    required this.category,
    required this.title,
    required this.image,
    required this.status,
    required this.price,
    required this.rating,
  });

  factory CoursesModel.fromJson(Map<String, dynamic> json) =>
      _$CoursesModelFromJson(json);
}
