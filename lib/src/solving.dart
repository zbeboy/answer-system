class Solving {
  String answerSolvingId; // 错题id
  String answerSubjectId; // 题目id
  String selectKey; // 所选key
  String rightKey; // 正确key
  String userId; // 用户id
  String userName; // 用户名
  String answerReleaseId; // 发布id

  // json.encode会自动调用这里
  Map toJson() => {
    'answerSolvingId': answerSolvingId,
    'answerSubjectId': answerSubjectId,
    'selectKey': selectKey,
    'rightKey': rightKey,
    'userId': userId,
    'userName': userName,
    'answerReleaseId': answerReleaseId,
  };
}
