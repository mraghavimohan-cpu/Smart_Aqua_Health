import 'package:flutter/foundation.dart';

class TwilioService {
  void sendSMS(String number, String message) {
    debugPrint("Sending SMS to $number : $message");
  }

  void makeCall(String number) {
    debugPrint("Making voice call to $number");
  }
}
