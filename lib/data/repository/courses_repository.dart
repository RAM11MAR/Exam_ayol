import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/courses_model.dart';

class CoursesRepository {
  final String _url = 'https://your.api/courses'; // API link o‘zingnikiga almashtir

  Future<List<CoursesModel>> fetchCourses() async {
    final res = await http.get(Uri.parse(_url));
    if (res.statusCode == 200) {
      List data = json.decode(res.body);
      return data.map((e) => CoursesModel.fromJson(e)).toList();
    } else {
      throw Exception('Kurslar yuklanmadi');
    }
  }
}
