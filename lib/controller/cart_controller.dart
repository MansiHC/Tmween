import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/cart_quantity_model.dart';
import 'package:tmween/model/cart_recent_viewed_product_model.dart';
import 'package:tmween/model/recommended_product_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

import '../model/get_cart_products_model.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class CartController extends GetxController {
  late BuildContext context;

  int userId = 0;
  String token = '';
  int loginLogId = 0;
  bool freeChecked = false;
   List<CartQuantityModel> cartQuantityList = [];
   List<int> wishListedProduct = [];

  List<CartRecentViewedProductModel> cartRecentViewedProducts =
      const <CartRecentViewedProductModel>[
    const CartRecentViewedProductModel(
        title:
            'Canon EOS 1300D 18MP Digital SLR Camera (Black) with 18-55mm ISII Lens, 16GB Card and Carry Case',
        rating: '4.1',
        offerPrice: '120',
        price: '1340',
        isFulFilled: true,
        isYouSave: true,
        saveOffer: '39',
        savePrice: '4,000',
        image: 'asset/image/my_cart_images/my_cart_img.jpg'),
    const CartRecentViewedProductModel(
        title:
            'Canon EOS 1300D 18MP Digital SLR Camera (Black) with 18-55mm ISII Lens, 16GB Card and Carry Case',
        rating: '4.1',
        offerPrice: '120',
        price: '1340',
        isFulFilled: true,
        isYouSave: true,
        saveOffer: '39',
        savePrice: '4,000',
        image: 'asset/image/my_cart_images/my_cart_img.jpg'),
    const CartRecentViewedProductModel(
        title:
            'Canon EOS 1300D 18MP Digital SLR Camera (Black) with 18-55mm ISII Lens, 16GB Card and Carry Case',
        rating: '4.1',
        offerPrice: '120',
        price: '1340',
        isFulFilled: true,
        isYouSave: true,
        saveOffer: '39',
        savePrice: '4,000',
        image: 'asset/image/my_cart_images/my_cart_img.jpg'),
  ];
  final api = Api();
  CartData? cartData;

  int cartCount = 0;
  bool isLogin = true;

  @override
  void onInit() {
    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isLogin)
        .then((value) async {
      isLogin = value!;
      print('...cart....$isLogin');
      if (isLogin)
        MySharedPreferences.instance
            .getStringValuesSF(SharedPreferencesKeys.token)
            .then((value) async {
          token = value!;
          print('dhsh.....$token');
          MySharedPreferences.instance
              .getIntValuesSF(SharedPreferencesKeys.userId)
              .then((value) async {
            userId = value!;
            getCartCount(Get.locale!.languageCode);
            MySharedPreferences.instance
                .getIntValuesSF(SharedPreferencesKeys.loginLogId)
                .then((value) async {
              loginLogId = value!;
            });
          });
        });
    });

    super.onInit();
  }

  Future<void> getCartProducts(language) async {
    Helper.showLoading();
    cartQuantityList=[];
    wishListedProduct=[];
    await api.getCartItems(token, userId, language).then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        cartData = value.data!;
        cartCount = cartData!.totalItems!;
        for (var i = 0; i < cartData!.cartDetails!.length; i++) {
          var q = CartQuantityModel();
          q.setQuantity = cartData!.cartDetails![i].quantity!;
          q.setProductId = cartData!.cartDetails![i].productId!;
          cartQuantityList.add(q);
        }
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }

      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> getCartCount(language) async {
    await api.getCartItems(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        cartCount = value.data!.totalItems!;
        update();
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> addToWishlist(productId, language) async {
    Helper.showLoading();
    await api
        .addDataToWishlist(token, userId, productId, language)
        .then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        wishListedProduct.add(productId);
        update();
        Helper.showGetSnackBar(value.message!,  AppColors.successColor);
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        wishListedProduct.add(productId);
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!,  AppColors.errorColor);
      }
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> editCartProductDecrease(productId,quoteId,qty,addressId, language,oldQty,index) async {
    Helper.showLoading();
    var q = oldQty-1;
    print('......${q}');
    await api
        .editCartItem(token, productId,quoteId,userId,q,addressId, language)
        .then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);

          oldQty = qty--;
       cartQuantityList[index]
              .setQuantity = qty--;
       cartCount--;
        update();

        Helper.showGetSnackBar(value.message!,  AppColors.successColor);
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        wishListedProduct.add(productId);
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!,  AppColors.errorColor);
      }
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> editCartProductIncrease(productId,quoteId,qty,addressId, language,oldQty,index) async {
    Helper.showLoading();
    var q = oldQty+1;
    print('......${q}');
    await api
        .editCartItem(token, productId,quoteId,userId,q,addressId, language)
        .then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        oldQty = qty++;
       cartQuantityList[index]
            .setQuantity = qty++;
       cartCount++;
        update();
        Helper.showGetSnackBar(value.message!,  AppColors.successColor);
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        wishListedProduct.add(productId);
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!,  AppColors.errorColor);
      }
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> deleteCartProduct(productId,quoteId,productItemId,addressId, language) async {
    Helper.showLoading();
    await api
        .removeCartItem(token, productId,quoteId,userId,productItemId,addressId, language)
        .then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!,  AppColors.successColor);
        getCartProducts(language);
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        wishListedProduct.add(productId);
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!,  AppColors.errorColor);
      }
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  List<RecommendedProductModel> recommendedProducts =
      const <RecommendedProductModel>[
    const RecommendedProductModel(
        title:
            'Canon EOS 1300D 18MP Digital SLR Camera (Black) with 18-55mm ISII Lens, 16GB Card and Carry Case',
        offerPrice: '120',
        price: '1340',
        isFulFilled: true,
        isYouSave: true,
        saveOffer: '39',
        savePrice: '4,000',
        image: 'asset/image/my_cart_images/my_cart_img.jpg'),
    const RecommendedProductModel(
        title:
            'Canon EOS 1300D 18MP Digital SLR Camera (Black) with 18-55mm ISII Lens, 16GB Card and Carry Case',
        offerPrice: '120',
        price: '1340',
        isFulFilled: true,
        isYouSave: true,
        saveOffer: '39',
        savePrice: '4,000',
        image: 'asset/image/my_cart_images/my_cart_img.jpg'),
    const RecommendedProductModel(
        title:
            'Canon EOS 1300D 18MP Digital SLR Camera (Black) with 18-55mm ISII Lens, 16GB Card and Carry Case',
        offerPrice: '120',
        price: '1340',
        isFulFilled: true,
        isYouSave: true,
        saveOffer: '39',
        savePrice: '4,000',
        image: 'asset/image/my_cart_images/my_cart_img.jpg'),
  ];

  void exitScreen() {
    Navigator.of(context).pop();
  }

  void pop() {
    Navigator.of(context).pop(false);
    update();
  }

  void navigateToDashboardScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DrawerScreen()),
        (Route<dynamic> route) => false);
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
