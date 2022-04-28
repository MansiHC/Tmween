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


  final api = Api();
  CartDetails? cartData;
  List<RecommendationProducts>? recommendedProductsData;
  List<RecentlyViewedProducts>? recentlyViewedProducts;
  List<String>? productIdList=[];

  int cartCount = 0;
  bool isLogin = true;
  late double totalAmount;
  late double shippingAmount;
  late double taxAmount;

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
    cartQuantityList = [];
    wishListedProduct = [];
    productIdList=[];
    cartData = null;
    await api.getCartItems(token, userId, language).then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        cartData = value.data!.cartDetails;
        recommendedProductsData = value.data!.recommendationProducts;
        recentlyViewedProducts = value.data!.recentlyViewedProducts;
        cartCount = cartData!.totalItems!;
        totalAmount=cartData!.totalPrice!.toPrecision(1);
        shippingAmount=cartData!.totalDeliveryPrice!.toPrecision(1);
        taxAmount=cartData!.totalTaxAmount!;
        for (var i = 0; i < cartData!.cartItemDetails!.length; i++) {
          productIdList!.add(cartData!.cartItemDetails![i].productId.toString());
          var q = CartQuantityModel();
          q.setQuantity = cartData!.cartItemDetails![i].quantity!;
          q.setProductId = cartData!.cartItemDetails![i].productId!;
          cartQuantityList.add(q);

        }
        for(var i=0;i<recentlyViewedProducts!.length;i++){
          if(recentlyViewedProducts![i].isWishlist==1)
            wishListedProduct.add(recentlyViewedProducts![i].id!);
        }
        update();
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }else{
        update();
      }


    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> getCartCount(language) async {
    await api.getCartItems(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        cartCount = value.data!.cartDetails!.totalItems!;
        update();
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }
    }).catchError((error) {
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
        Helper.showGetSnackBar(value.message!, AppColors.successColor);
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        wishListedProduct.add(productId);
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
      }
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> removeWishlistProduct(productId,language) async {
    //  if (Helper.isIndividual) {
    print('remove......');
    await api
        .deleteWishListDetails(token, productId, userId, language)
        .then((value) {
      if (value.statusCode == 200) {
        wishListedProduct.remove(productId);
        update();
        Helper.showGetSnackBar(value.message!, AppColors.successColor);
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
      }
      update();
    }).catchError((error) {
      print('error....$error');
    });
    //  }
  }



  Future<void> editCartProductDecrease(
      id, productId,quoteId, qty, language, oldQty, index) async {
    Helper.showLoading();
    var q = qty - 1;
    print('......${q}');
    await api
        .editCartItem(token, id, quoteId, userId, q, language)
        .then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);

        oldQty = qty--;
        cartQuantityList[index].setQuantity = value.data!.quoteItem![0].quantity!;
        cartCount = value.data!.cartTotalItems!;
       totalAmount =  value.data!.quote![0].grandTotal!.toPrecision(1);
        shippingAmount=value.data!.quote![0].shippingPrice!.toPrecision(1);
        taxAmount=value.data!.quote![0].taxAmount!;
        update();

        Helper.showGetSnackBar(value.message!, AppColors.successColor);
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        wishListedProduct.add(productId);
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
      }
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> editCartProductIncrease(
      id,productId,quoteId, qty, language, oldQty, index) async {
    Helper.showLoading();
    var q = qty + 1;
    print('......${q}....$oldQty...$qty');
    await api
        .editCartItem(token, id, quoteId, userId, q,  language)
        .then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        oldQty = qty++;
        cartQuantityList[index].setQuantity = value.data!.quoteItem![0].quantity!;
        cartCount = value.data!.cartTotalItems!;
        totalAmount =  value.data!.quote![0].grandTotal!.toPrecision(1);
        shippingAmount=value.data!.quote![0].shippingPrice!.toPrecision(1);
        taxAmount=value.data!.quote![0].taxAmount!;
        update();
        Helper.showGetSnackBar(value.message!, AppColors.successColor);
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        wishListedProduct.add(productId);
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
      }
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> deleteCartProduct(
      quoteId, quoteItemId, language, qty) async {
    Helper.showLoading();
    await api
        .removeCartItem(token, quoteId, userId, quoteItemId,
            language)
        .then((value) {
      if (value.statusCode == 200) {
        cartCount = cartCount - int.parse(qty.toString());
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!, AppColors.successColor);
        getCartProducts(language);
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
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
