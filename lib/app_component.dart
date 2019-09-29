import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  directives: [coreDirectives, formDirectives],
)
class AppComponent implements AfterViewInit {
  var startTime = '2019-10-13 09:10:00';
  var endTime = '2019-10-13 09:40:00';
  var residueTime;
  var realName;
  var studentNumber;

  void calculationResidueTime() {
    Timer.periodic(Duration(minutes: 1), handleResidueTime);
  }

  void handleResidueTime(Timer timer) {
    residueTime =
        DateTime(2019, 9, 30, 1, 0, 0, 0).difference(DateTime.now()).inMinutes;
  }

  @override
  void ngAfterViewInit() {
    calculationResidueTime();
  }
}
