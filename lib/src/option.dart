

class Option {
  final String answerOptionId; // 选项id
  String optionContent; // 选项内容
  int sort; // 排序
  String optionKey; // 选项key
  String answerSubjectId; // 题目id
  String selectedKey;// 选择的key

  Option(this.answerOptionId, this.optionContent, this.sort, this.optionKey,
      this.answerSubjectId);

  static List<Option> toOptionList(List<dynamic> options) {
    List<Option> list = List();
    if (null != options) {
      for (Map<String, dynamic> option in options) {
        list.add(Option.fromJson(option));
      }
    }
    return list;
  }

  factory Option.fromJson(Map<String, dynamic> option) => Option(
        null != option['answerOptionId'] ? option['answerOptionId'] : '',
        null != option['optionContent'] ? option['optionContent'] : '',
        null != option['sort'] ? _toInt(option['sort']) : null,
        null != option['optionKey'] ? option['optionKey'] : '',
        null != option['answerSubjectId'] ? option['answerSubjectId'] : '',
      );

  Map toJson() => {
        'answerOptionId': answerOptionId,
        'optionContent': optionContent,
        'sort': sort,
        'optionKey': optionKey,
        'answerSubjectId': answerSubjectId,
      };
}

int _toInt(id) => id is int ? id : int.parse(id);
