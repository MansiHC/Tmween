import 'package:flutter/cupertino.dart';

class OtpProvider extends ChangeNotifier {
  late BuildContext context;

  bool click1 = false;
  bool click2 = false;
  bool click3 = false;
  bool click4 = false;

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
