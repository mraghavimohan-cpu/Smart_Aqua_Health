class TwilioService {

  void sendSMS(String number, String message) {
    print("Sending SMS to $number : $message");
  }

  void makeCall(String number) {
    print("Making voice call to $number");
  }
}