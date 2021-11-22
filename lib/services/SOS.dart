import 'dart:developer';

import 'package:students_safety_app/helper_functions/shared_preferences.dart';
import 'package:students_safety_app/services/PositionDetails.dart';
import 'package:students_safety_app/utils/LocationUtil.dart';
import 'package:students_safety_app/utils/SmsUtil.dart';

class SosMethods {
  static sendSOS() async {
    log('SOS triggered');

    PositionDetails? positionDetails = await LocationUtil.determinePosition();
    final latitude = positionDetails!.position.latitude;
    final longitude = positionDetails.position.longitude;
    String address = positionDetails.address;

    String? messageHead = await SharedPreferenceHelper.getMessageHead();

    String messageBody =
        "https://www.google.com/maps/search/?api=1&query=$latitude%2C$longitude. $address";

    final message = messageHead! + messageBody;

    await SmsUtil.initiateSendSMS(message);
  }
}
