import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/models/data_model.dart';

class DataService {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<DataModel>> fetchData() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => DataModel.fromJson(item)).toList();
    } else {
      throw Exception('Ma\'lumotlarni yuklab bo\'lmadi');
    }
  }
}
