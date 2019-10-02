class Release {
  final String answerReleaseId; // 发布id
  String title; // 发布标题
  DateTime releaseTime; // 发布时间
  DateTime startTime; // 考试开始时间
  DateTime endTime; // 考试结束时间
  String answerBankId;// 题库id
  String username;// 创建人账号

  Release(this.answerReleaseId, this.title, this.releaseTime, this.startTime,
      this.endTime, this.answerBankId, this.username);

  factory Release.fromJson(Map<String, dynamic> release) => Release(
      release['answerReleaseId'],
      release['title'],
      _toDateTime(release['releaseTimeStr']),
      _toDateTime(release['startTimeStr']),
      _toDateTime(release['endTimeStr']),
      release['answerBankId'],
      release['username'],
  );

  Map toJson() => {
        'id': answerReleaseId,
        'title': title,
        'createDate': releaseTime,
        'startTime': startTime,
        'endTime': endTime,
        'answerBankId': answerBankId,
        'username': username,
      };
}

DateTime _toDateTime(time) => time is DateTime ? time : DateTime.parse(time);
