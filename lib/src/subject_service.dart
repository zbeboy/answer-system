import 'dart:convert';

import 'package:answer_system/src/subject.dart';
import 'package:answer_system/src/work_book.dart';
import 'package:http/http.dart';

class SubjectService {
  final Client _http;

  SubjectService(this._http);

  Future<Subject> get(
      String answerBankId, int customId) async {
    try {
      final subjectUrl = WorkBook.subjectUrl;
      final response = await _http.post(subjectUrl,
          headers: WorkBook.headers,
          body: json.encode({
            'answerBankId': answerBankId,
            'customId': customId
          }));
      return Subject.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => jsonDecode(Utf8Decoder().convert(resp.bodyBytes))['subject'];

  Exception _handleError(dynamic e) {
    print(e);
    return Exception('Server error; cause: $e');
  }
}
