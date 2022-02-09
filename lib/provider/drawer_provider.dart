import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:tmween/screens/drawer/CartScreen.dart';
import 'package:tmween/screens/drawer/categories_screen.dart';
import 'package:tmween/screens/drawer/dashboard/dashboard_screen.dart';
import 'package:tmween/screens/drawer/search_screen.dart';
import 'package:tmween/screens/drawer/wishlist_screen.dart';

class DrawerProvider extends ChangeNotifier {
  late BuildContext context;
  int pageIndex = 0;

  final pages = [
    DashboardScreen(),
    CategoriesScreen(),
    SearchScreen(),
    WishlistScreen(),
    CartScreen()
  ];

  void changePage(int pageNo){
    pageIndex = pageNo;
    notifyListeners();
  }

  void pop(){
    Navigator.of(context).pop(false);
    notifyListeners();
  }

  void exit(){
    SystemNavigator.pop();
    notifyListeners();
  }
}