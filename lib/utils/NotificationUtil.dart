
import 'package:students_safety_app/helper_functions/shared_preferences.dart';
import 'package:students_safety_app/services/SOS.dart';

class NotificationUtil {
  static int? maxStep;
  static int? simulatedStep;

  static Future<void> Notify(int id) async {
    int? sosDelayTime = await SharedPreferenceHelper.getSOSdelayTime();
    if (sosDelayTime != null) {
      print('delay time is $sosDelayTime');
      maxStep = sosDelayTime;
    } else {
      maxStep = 5;
      await SharedPreferenceHelper.saveSOSdelayTime(maxStep!);
    }
    for (simulatedStep = 1; simulatedStep! <= maxStep! + 1; simulatedStep = simulatedStep! + 1) {
      await Future.delayed(
        Duration(seconds: 1),
            () async {
          if (simulatedStep == maxStep! + 1) {
            SosMethods.sendSOS();
          }
        },
      );
    }
  }
}