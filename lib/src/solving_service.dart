import 'dart:convert';

import 'package:answer_system/src/response_data.dart';
import 'package:answer_system/src/solving.dart';
import 'package:answer_system/src/work_book.dart';
import 'package:http/http.dart';

class SolvingService {
  final Client _http;

  SolvingService(this._http);

  Future<ResponseData> save(List<Solving> solvings) async {
    try {
      final solvingUrl = WorkBook.solvingUrl;
      final response = await _http.post(solvingUrl,
          headers: WorkBook.headers, body: json.encode(solvings));
      return ResponseData.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => json.decode(resp.body);

  Exception _handleError(dynamic e) {
    print(e);
    return Exception('Server error; cause: $e');
  }
}
