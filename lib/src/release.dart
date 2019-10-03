class Release {
  final String answerReleaseId; // 发布id
  String title; // 发布标题
  DateTime releaseTime; // 发布时间
  DateTime startTime; // 考试开始时间
  DateTime endTime; // 考试结束时间
  String answerBankId; // 题库id
  String username; // 创建人账号

  Release(this.answerReleaseId, this.title, this.releaseTime, this.startTime,
      this.endTime, this.answerBankId, this.username);

  factory Release.fromJson(Map<String, dynamic> release) => Release(
        null != release['answerReleaseId'] ? release['answerReleaseId'] : '',
        null != release['title'] ? release['title'] : '',
        null != release['releaseTimeStr']
            ? _toDateTime(release['releaseTimeStr'])
            : null,
        null != release['startTimeStr']
            ? _toDateTime(release['startTimeStr'])
            : null,
        null != release['endTimeStr']
            ? _toDateTime(release['endTimeStr'])
            : null,
        null != release['answerBankId'] ? release['answerBankId'] : '',
        null != release['username'] ? release['username'] : '',
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
