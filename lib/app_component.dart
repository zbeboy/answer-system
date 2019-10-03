import 'dart:async';
import 'dart:math';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:answer_system/src/release.dart';
import 'package:answer_system/src/release_service.dart';
import 'package:answer_system/src/subject.dart';
import 'package:answer_system/src/subject_service.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  directives: [coreDirectives, formDirectives],
  providers: [ClassProvider(ReleaseService), ClassProvider(SubjectService)],
)
class AppComponent implements AfterViewInit {
  var startTime;
  var endTime;
  var residueTime;
  var realName;
  var studentNumber;
  var msg;

  Release release;
  List<Subject> subjects = List();
  Subject cuSubject;
  List<int> subjectCustomList = List();
  int subjectIndex = 0;

  final ReleaseService _releaseService;
  final SubjectService _subjectService;

  AppComponent(this._releaseService, this._subjectService);

  void createResidueTime() {
    Timer.periodic(Duration(minutes: 1), handleResidueTime);
  }

  void handleResidueTime(Timer timer) {
    calculationResidueTime();
  }

  void calculationResidueTime() {
    residueTime = release.endTime.difference(DateTime.now()).inMinutes;
  }

  void initSubject(String answerBankId) async {
    // 随机0~100之间，20个数不重复
    var random = Random();
    int i = 0;
    while (i < 20) {
      int num = random.nextInt(100);
      if (!subjectCustomList.contains(num)) {
        subjectCustomList.add(num);
        i++;
      }
    }
    // 查询组装题目
    for (int j in subjectCustomList) {
      var subject = await _subjectService.get(answerBankId, j);
      if(null != subject.answerSubjectId && ''!=subject.answerSubjectId)
      subjects.add(subject);
    }

    if(subjects.isEmpty){
      subjectCustomList.clear();
    } else {
      Iterable<Subject> it = subjects.getRange(subjectIndex, subjectIndex+1);
      cuSubject = it.first;
    }
  }

  @override
  void ngAfterViewInit() async {
    release = await _releaseService.get('1');
    startTime = release.startTime;
    endTime = release.endTime;
    var now = DateTime.now();
    if (null != startTime &&
        null != endTime &&
        now.isAfter(startTime) &&
        now.isBefore(endTime)) {
      createResidueTime();
      calculationResidueTime();
      initSubject(release.answerBankId);
    } else {
      msg = '未在考试时间范围';
    }
  }
}
