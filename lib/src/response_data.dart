class ResponseData{
  String msg;
  bool state;

  ResponseData(this.msg, this.state);

  factory ResponseData.fromJson(Map<String, dynamic> responseData) => ResponseData(
    null != responseData['msg'] ? responseData['msg'] : '',
    null != responseData['state'] ? _toBool(responseData['state']) : false,
  );

  Map toJson() => {
    'msg': msg,
    'state': state,
  };
}

bool _toBool(id) => id is bool ? id : bool.fromEnvironment(id);