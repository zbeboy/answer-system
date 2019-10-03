import 'package:answer_system/src/option.dart';

class Subject {
  final String answerSubjectId; // 题目id
  String content; // 题目内容
  int subjectType; // 题目类型 0:单选
  String answerBankId; // 题库id
  double score; // 分值
  int customId; // 自定义id
  List<Option> options; // 选项

  Subject(this.answerSubjectId, this.content, this.subjectType,
      this.answerBankId, this.score, this.customId, this.options);

  factory Subject.fromJson(Map<String, dynamic> subject) => Subject(
      null != subject['answerSubjectId'] ? subject['answerSubjectId'] : '',
      null != subject['content'] ? subject['content'] : '',
      null != subject['subjectType'] ? _toInt(subject['subjectType']) : null,
      null != subject['answerBankId'] ? subject['answerBankId'] : '',
      null != subject['score'] ? _toDouble(subject['score']) : null,
      null != subject['customId'] ? _toInt(subject['customId']) : null,
      null != subject['options']
          ? Option.toOptionList(subject['options'])
          : null);

  Map toJson() => {
        'answerSubjectId': answerSubjectId,
        'content': content,
        'subjectType': subjectType,
        'answerBankId': answerBankId,
        'score': score,
        'customId': customId,
        'options': options,
      };
}

int _toInt(id) => id is int ? id : int.parse(id);

double _toDouble(id) => id is double ? id : double.parse(id);
