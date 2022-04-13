import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/AttributeModel.dart';
import 'package:tmween/screens/drawer/dashboard/product_detail_screen.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/utils/global.dart';

import '../model/attribute_combination_model.dart';
import '../model/get_customer_address_list_model.dart';
import '../model/product_detail_model.dart';
import '../service/api.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class ProductDetailController extends GetxController {
  late BuildContext context;
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late bool visibleList = false;
  late bool isLiked = false;
  bool descTextShowFlag = false;

  int current = 0;
  int productId = 0;
  String productSlug = '';
  final CarouselController controller = CarouselController();
  late String selectedColor;
  int userId = 0;
  String token = '';
  int loginLogId = 0;
  bool addressFromCurrentLocation = false;
  final api = Api();
  bool loading = false;
  bool detailLoading = false;
  ProductDetailData? productDetailData;
  AttributeData? attributeData;
  ProductOtherInfo? topLeftInfo;
  ProductOtherInfo? topRightInfo;
  ProductOtherInfo? bottomLeftInfo;
  ProductOtherInfo? bottomRightInfo;
  List<Address> addressList = [];
  bool isLogin = true;
  String image = "", address = "", addressId = "";
  List<String> attributeTypeArr = [];
  List<String> attributeValueArray = [];
  final List<AttributeModel> attributeItems = [];
  int packId = 0;
  int quntity = 1;

  @override
  void onInit() {
    isLiked = false;

    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.address)
        .then((value) async {
      if (value != null) address = value;
      update();
    });
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.addressId)
        .then((value) async {
      if (value != null) addressId = value;
      update();
    });
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.address)
        .then((value) async {
      if (value != null) address = value;
      update();
    });
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.image)
        .then((value) async {
      image = value!;
      update();
    });
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.token)
        .then((value) async {
      token = value!;
      print('dhsh.....$token');
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.userId)
          .then((value) async {
        userId = value!;
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          loginLogId = value!;
        });
      });
    });
    super.onInit();
  }

  Future<void> getProductDetails(language) async {
    Helper.showLoading();
    attributeTypeArr = [];
    attributeValueArray = [];
    await api
        .getProductDetailsMobile(productSlug, isLogin, userId, language)
        .then((value) {
      if (value.statusCode == 200) {
        productDetailData = value.data!;
        packId = productDetailData!.productData![0].productPack![0].id!;
        if (productDetailData!.productAssociateAttribute != null) {
          for (var i = 0;
              i < productDetailData!.productAssociateAttribute!.length;
              i++) {
            if (productDetailData!.productAssociateAttribute![i].options !=
                null) {
              attributeTypeArr.add(productDetailData!
                  .productAssociateAttribute![i].attributeName!);
              if (productDetailData!.productAssociateAttribute![i].options![0]
                      .attributeOptionValue ==
                  null)
                attributeValueArray.add(productDetailData!
                    .productAssociateAttribute![i]
                    .options![0]
                    .attributeOptionValue!);
            }
            var a = AttributeModel();
            a.setPrimaryIndex = i;
            a.setSecondaryIndex = 0;
            attributeItems.add(a);
          }
          if (attributeTypeArr.length == 0) {
            getAttributeWithoutCombination(packId, language, 0);
          } else {
            getAttributeCombination(packId, language, 0);
          }
        } else {
          Helper.hideLoading(context);
          update();
        }
        for (var i = 0; i < productDetailData!.productOtherInfo!.length; i++) {
          if (productDetailData!.productOtherInfo![i].position == 1) {
            topLeftInfo = productDetailData!.productOtherInfo![i];
          } else if (productDetailData!.productOtherInfo![i].position == 2) {
            topRightInfo = productDetailData!.productOtherInfo![i];
          } else if (productDetailData!.productOtherInfo![i].position == 3) {
            bottomLeftInfo = productDetailData!.productOtherInfo![i];
          } else if (productDetailData!.productOtherInfo![i].position == 4) {
            bottomRightInfo = productDetailData!.productOtherInfo![i];
          }
        }
        if (isLogin) if (productDetailData!.productData![0].isWhishlist == 1) {
          isLiked = true;
        }
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!);
      }
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  String getAttributeSelectedValue(index) {
    String name = '';
    if (attributeTypeArr.length > 0)
      for (var i = 0; i < attributeTypeArr.length; i++) {
        if (productDetailData!
                .productAssociateAttribute![index].attributeName ==
            attributeTypeArr[i]) {
          print('.......$attributeTypeArr.....$attributeValueArray');
          if (attributeValueArray.length > 0) name = attributeValueArray[i];
        }
      }
    return name;
  }

  changeItemSelection(index, index2, language) async {
    attributeItems[index].setPrimaryIndex = index;
    attributeItems[index].setSecondaryIndex = index2;
    for (var i = 0; i < attributeTypeArr.length; i++) {
      if (productDetailData!.productAssociateAttribute![index].attributeName ==
          attributeTypeArr[i]) {
        attributeValueArray[i] = productDetailData!
            .productAssociateAttribute![index]
            .options![index2]
            .attributeOptionValue!;
      }

      update();
    }
    Helper.showLoading();
    if (attributeTypeArr.length == 0) {
      getAttributeWithoutCombination(packId, language, 1);
    } else {
      final Map<String, dynamic> attrData = {
        "attribute_type": attributeTypeArr,
        "attribute_value": attributeValueArray
      };
      print('$attrData.....$productId....$packId');
      await api
          .getItemIdByAttributeCombination(
              packId, productId, attrData, language)
          .then((value) {
        Helper.hideLoading(context);
        if (value.statusCode == 200) {
          attributeData = value.data;
        } else {
          Helper.showGetSnackBar(value.message!);
        }

        update();
      }).catchError((error) {
        Helper.hideLoading(context);
        update();
        print('error....$error');
      });
    }
  }

  Future<void> getAttributeCombination(productPackId, language, int i) async {
    if (i == 1) Helper.showLoading();
    final Map<String, dynamic> attrData = {
      "attribute_type": attributeTypeArr,
      "attribute_value": attributeValueArray
    };
    print('$attrData.....$productId....$productPackId');
    await api
        .getItemIdByAttributeCombination(
            productPackId, productId, attrData, language)
        .then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        attributeData = value.data;
      } else {
        Helper.showGetSnackBar(value.message!);
      }

      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> getAttributeWithoutCombination(
      productPackId, language, int i) async {
    if (i == 1) Helper.showLoading();
    await api
        .getProductSupplier(productPackId, productId, language)
        .then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        attributeData = value.data;
      } else {
        Helper.showGetSnackBar(value.message!);
      }

      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  void changPage(int index) {
    current = index;
    update();
  }

  Future<void> addToWishlist(language) async {
    addressList = [];
    print('add......$productId');
    await api
        .addDataToWishlist(token, userId, productId, language)
        .then((value) {
      if (value.statusCode == 200) {
        isLiked = true;
        update();
        Helper.showGetSnackBar(value.message!);
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        Helper.showGetSnackBar(value.message!);
      }
    }).catchError((error) {
      print('error....$error');
    });
  }

  Future<bool> addToCart(
      productItemId, supplierId, supplierBranchId, language) async {
    addressList = [];
    print(
        'add......$productId,$packId,$productItemId,$userId,$quntity,$addressId,$supplierId,$supplierBranchId');
    await api
        .addToCart(token, productId, packId, productItemId, userId, quntity,
            addressId, supplierId, supplierBranchId, language)
        .then((value) {
      if (value.statusCode == 200) {
        return true;
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
        return false;
      } else {
        Helper.showGetSnackBar(value.message!);
        return false;
      }
    }).catchError((error) {
      print('error....$error');
    });
    return false;
  }

  Future<void> removeWishlistProduct(language) async {
    //  if (Helper.isIndividual) {
    print('remove......');
    await api
        .deleteWishListDetails(token, productId, userId, language)
        .then((value) {
      if (value.statusCode == 200) {
        isLiked = false;
        update();
        Helper.showGetSnackBar(value.message!);
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        Helper.showGetSnackBar(value.message!);
      }
      update();
    }).catchError((error) {
      print('error....$error');
    });
    //  }
  }

  Future<void> getAddressList(language) async {
    addressList = [];
    Helper.showLoading();
    await api.getCustomerAddressList(token, userId, language).then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        addressList = value.data!;
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

  Future<void> editAddress(
      id,
      fullName,
      address1,
      address2,
      landmark,
      country,
      state,
      city,
      zip,
      mobile,
      addressType,
      deliveryInstruction,
      defaultValue,
      language) async {
    Helper.showLoading();
    await api
        .editCustomerAddress(
            token,
            id,
            userId,
            fullName,
            address1,
            address2,
            landmark,
            country,
            state,
            city,
            zip,
            mobile,
            addressType,
            deliveryInstruction,
            defaultValue,
            language)
        .then((value) {
      Helper.hideLoading(context);
      update();
      if (value.statusCode == 200) {
        Get.delete<ProductDetailController>();
        Navigator.of(context).pop(true);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                      productId: productId,
                      productslug: productSlug,
                    )));
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

  final List<String> items = ['Sofa', 'Bed'];

  int val = 1;

  bool isQuantityDiscountExpanded = true;

  void updateQuantityDiscountExpanded() {
    isQuantityDiscountExpanded = !isQuantityDiscountExpanded;
    update();
  }

  bool isProductInfoExpanded = true;

  void updateProductInfoExpanded() {
    isProductInfoExpanded = !isProductInfoExpanded;
    update();
  }

  bool isSpecificationExpanded = false;

  void updateSpecificationExpanded() {
    isSpecificationExpanded = !isSpecificationExpanded;
    update();
  }

  bool isSizeSpecificationExpanded = false;

  void updateSizeSpecificationExpanded() {
    isSizeSpecificationExpanded = !isSizeSpecificationExpanded;
    update();
  }

  bool isDeliveryReturnExpanded = false;

  void updateDeliveryReturnExpanded() {
    isDeliveryReturnExpanded = !isDeliveryReturnExpanded;
    update();
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  void navigateToCartScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => DrawerScreen(
                  from: AppConstants.productDetail,
                )),
        (Route<dynamic> route) => false);
  }

  void closeDrawer() {
    Navigator.pop(context);
  }

  void exitScreen() {
    Get.delete<ProductDetailController>();
    Navigator.of(context).pop();
  }

  void pop() {
    Navigator.of(context).pop(false);
    update();
  }

  void exit() {
    SystemNavigator.pop();
    update();
  }
}
