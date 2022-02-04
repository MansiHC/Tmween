import 'package:flutter/cupertino.dart';
import 'package:tmween/service/api.dart';
import 'package:tmween/utils/helper.dart';

class OtpProvider extends ChangeNotifier {
  late BuildContext context;

  bool click1 = false;
  bool click2 = false;
  bool click3 = false;
  bool click4 = false;
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  TextEditingController num3Controller = TextEditingController();
  TextEditingController num4Controller = TextEditingController();

  final api = Api();
  bool loading = false;
  late String phone, otp;

  verifyOTP() async {
    loading = true;
    notifyListeners();

    otp = num1Controller.text +
        num2Controller.text +
        num3Controller.text +
        num4Controller.text;

    await api.verifyOTP(context, 1, phone, otp).then((value) {
      loading = false;
      notifyListeners();
      Helper.showSnackBar(context, value.status_message!);
    });
  }

  void exitScreen() {
    Navigator.of(context).pop();
  }

  void notifyClick1(bool click) {
    click1 = click;
    notifyListeners();
  }

  void notifyClick2(bool click) {
    click2 = click;
    notifyListeners();
  }

  void notifyClick3(bool click) {
    click3 = click;
    notifyListeners();
  }

  void notifyClick4(bool click) {
    click4 = click;
    notifyListeners();
  }
}
