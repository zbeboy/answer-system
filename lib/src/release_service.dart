import 'dart:convert';

import 'package:http/http.dart';

import 'package:answer_system/src/release.dart';
import 'package:answer_system/src/work_book.dart';

class ReleaseService {
  final Client _http;

  ReleaseService(this._http);

  Future<Release> get(String id) async {
    try {
      final releaseUrl = WorkBook.releaseUrl;
      final response = await _http.get('$releaseUrl/$id');
      return Release.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => jsonDecode(Utf8Decoder().convert(resp.bodyBytes))['release'];

  Exception _handleError(dynamic e) {
    print(e);
    return Exception('Server error; cause: $e');
  }
}
