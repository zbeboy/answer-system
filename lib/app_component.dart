import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:answer_system/release.dart';
import 'package:answer_system/release_service.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  directives: [coreDirectives, formDirectives],
  providers: [ClassProvider(ReleaseService)],
)
class AppComponent implements AfterViewInit {
  var startTime;
  var endTime;
  var residueTime;
  var realName;
  var studentNumber;
  var subject;

  Release release;

  final ReleaseService _releaseService;

  AppComponent(this._releaseService);

  void createResidueTime() {
    Timer.periodic(Duration(minutes: 1), handleResidueTime);
  }

  void handleResidueTime(Timer timer) {
    calculationResidueTime();
  }

  void calculationResidueTime() {
    residueTime = release.endTime.difference(DateTime.now()).inMinutes;
  }

  @override
  void ngAfterViewInit() async {
    release = (await _releaseService.get('1'));
    startTime = release.startTime;
    endTime = release.endTime;
    var now = DateTime.now();
    if (now.isAfter(startTime) && now.isBefore(endTime)) {
      calculationResidueTime();
      createResidueTime();
    } else {
      subject = '未在考试时间范围';
    }
  }
}
