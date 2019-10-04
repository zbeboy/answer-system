import 'dart:async';
import 'dart:math';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:answer_system/src/option.dart';
import 'package:answer_system/src/release.dart';
import 'package:answer_system/src/release_service.dart';
import 'package:answer_system/src/response_data.dart';
import 'package:answer_system/src/solving.dart';
import 'package:answer_system/src/solving_service.dart';
import 'package:answer_system/src/subject.dart';
import 'package:answer_system/src/subject_service.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  directives: [coreDirectives, formDirectives],
  providers: [
    ClassProvider(ReleaseService),
    ClassProvider(SubjectService),
    ClassProvider(SolvingService)
  ],
)
class AppComponent implements AfterViewInit {
  var startTime;
  var endTime;
  var residueTime;
  var realName;
  var studentNumber;
  var msg;
  var prevButtonText = '上一题';
  var nextButtonText = '下一题';
  var prevLoading = 0;
  var nextLoading = 0;
  var submitStyle;
  var submitMsg;

  Release release;
  List<Subject> subjects = List();
  Subject cuSubject;
  List<int> subjectCustomList = List();
  int subjectIndex = 0;

  final ReleaseService _releaseService;
  final SubjectService _subjectService;
  final SolvingService _solvingService;

  AppComponent(
      this._releaseService, this._subjectService, this._solvingService);

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
      if (null != subject.answerSubjectId && '' != subject.answerSubjectId)
        subjects.add(subject);
    }

    if (subjects.isEmpty) {
      subjectCustomList.clear();
    } else {
      resetSubject();
    }
  }

  void resetSubject() {
    Iterable<Subject> it = subjects.getRange(subjectIndex, subjectIndex + 1);
    cuSubject = it.first;

    if (subjectIndex == subjects.length - 1) {
      nextButtonText = '交卷';
    } else {
      nextButtonText = '下一题';
    }
  }

  void prevSubject() {
    prevLoading = 1;
    if (subjectIndex > 0) {
      subjectIndex--;
      resetSubject();
      prevLoading = 0;
    }
  }

  void nextSubject() async {
    nextLoading = 1;
    if (subjectIndex < subjects.length - 1) {
      subjectIndex++;
      resetSubject();
      nextLoading = 0;
      submitStyle = '';
      submitMsg = '';
    } else {
      // 交卷操作
      nextLoading = 0;
      submitStyle = '';
      submitMsg = '';
      if (null == realName || '' == realName.toString().trim()) {
        submitStyle = 'text-danger';
        submitMsg = '请填写姓名';
        return;
      }

      if (null == studentNumber || '' == studentNumber.toString().trim()) {
        submitStyle = 'text-danger';
        submitMsg = '请填写学号';
        return;
      }

      List<int> selectKeyCheck = List();
      for (int k = 0; k < subjects.length; k++) {
        bool hasSelect = false;
        for (Option o in subjects[k].options) {
          if (null != o.selectedKey) {
            hasSelect = true;
            break;
          }
        }

        if (!hasSelect) {
          selectKeyCheck.add(k + 1);
        }
      }

      if (selectKeyCheck.length > 0) {
        submitStyle = 'text-danger';
        submitMsg = '您有题目未做完:' + selectKeyCheck.toString();
        return;
      }

      List<Solving> solvings = List();
      for (Subject s in subjects) {
        Solving solving = Solving();
        solving.answerSubjectId = s.answerSubjectId;
        solving.userId = studentNumber;
        solving.userName = realName;
        solving.answerReleaseId = release.answerReleaseId;
        for (Option o in s.options) {
          if (null != o.selectedKey) {
            solving.selectKey = o.selectedKey;
          }
        }

        solvings.add(solving);
      }

      ResponseData responseData = await _solvingService.save(solvings);
      if (responseData.state) {
        submitStyle = 'text-success';
      } else {
        submitStyle = 'text-danger';
      }
      submitMsg = responseData.msg;
    }
  }

  void selectSubject(int i) {
    subjectIndex = i;
    resetSubject();
  }

  void selectedKey(String answerOptionId, String optionKey) {
    cuSubject.options
        .firstWhere((h) => h.answerOptionId == answerOptionId)
        .selectedKey = optionKey;
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
