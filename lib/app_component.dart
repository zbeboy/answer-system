import 'dart:async';
import 'dart:math';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  directives: [coreDirectives, formDirectives],
)
class AppComponent {
  var startTime = DateTime(2019, 9, 30, 9, 10, 0, 0);
  var endTime = DateTime(2019, 9, 30, 18, 40, 0, 0);
  var residueTime;
  var realName;
  var studentNumber;
  var subject;
  List<int> subjectNum;

  AppComponent() {
    var nowDate = DateTime.now();
    // 在考试范围
    if (nowDate.isAfter(startTime) && nowDate.isBefore(endTime)) {
      residueTime = endTime.difference(nowDate).inMinutes;
      Timer.periodic(Duration(minutes: 1), handleResidueTime);
      var i = 0;
      var r = Random();
      subjectNum = [];
      while(i<20){
        var num = r.nextInt(100);
        if (!subjectNum.contains(num)) {
          subjectNum.add(num);
          i++;
        }
      }
      subject = '以下答案正确的是：';
    } else {
      residueTime = endTime.difference(startTime).inMinutes;
      subject = '未在考试时间范围';
    }
  }

  void handleResidueTime(Timer timer) {
    residueTime = endTime.difference(DateTime.now()).inMinutes;
  }
}
