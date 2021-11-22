import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students_safety_app/helper_functions/database_helper.dart';
import 'package:students_safety_app/services/contacts.dart';
import 'package:telephony/telephony.dart';

class SmsUtil {
  static Future<bool> initiateSendSMS(String message) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    List<TContact> contactList = await databaseHelper.getContactList();
    String recipients = "";
    int i = 1;
    for (TContact contact in contactList) {
      recipients += contact.number!;
      if (i != contactList.length) {
        recipients += ";";
        i++;
      }
    }

    bool result = await sendSMS2Recipients(recipients, message);

    return result;
  }

  static Future<bool> sendSMS2Recipients(
      String recipients, String message) async {
    final Telephony telephony = Telephony.instance;

    bool serviceEnabled;

    serviceEnabled = (await telephony.requestSmsPermissions)!;
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please allow SMS Permission',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red);

      serviceEnabled = (await telephony.requestSmsPermissions)!;
    }

    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'SMS Permission is not being granted. App will be unable to '
          'send SOS SMS to your added trusted contacts',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red);

      return false;
    } else {
      final SmsSendStatusListener listener = (SendStatus status) {
        if (status == SendStatus.SENT || status == SendStatus.DELIVERED) {
          print(status);
          log('SmsSendStatusListener report: SMS was sent!');
          Fluttertoast.showToast(msg: 'SOS Sent!',
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.greenAccent);
        } else {
          print(status);
          log('SmsSendStatusListener report: SMS was not sent!');
          Fluttertoast.showToast(msg: 'Sending SOS SMS Failed!',
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.redAccent);
        }
      };
      List<String> recipientList = recipients.split(';');

      for (String recipient in recipientList) {
        // This one supports all android devices..
        await telephony.sendSms(
          to: recipient,
          message: message,
          isMultipart: true,
          statusListener: listener,
        );
      }
      return true;
    }
  }
}
