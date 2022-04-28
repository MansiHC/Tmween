import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/controller/cart_controller.dart';
import 'package:tmween/model/AttributeModel.dart';
import 'package:tmween/screens/drawer/cart/cart_screen.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../model/attribute_combination_model.dart';
import '../model/get_customer_address_list_model.dart';
import '../model/product_detail_model.dart';
import '../screens/drawer/productDetail/product_detail_screen.dart';
import '../service/api.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class ProductDetailController extends GetxController {
  late BuildContext context;
  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  late bool visibleList = false;
  late bool isLiked = false;
  bool descTextShowFlag = false;
  bool isWithAttribute = false;

  int current = 0;
  int productId = 0;
  String productSlug = '';
  String reviewMessage = '';
  String reportMessage = '';
  final CarouselController controller = CarouselController();
  late String selectedColor;
  int userId = 0;
  String token = '';
  int loginLogId = 0;
  bool addressFromCurrentLocation = false;
  final api = Api();
  bool loading = false;
  bool detailLoading = false;
  bool addedToCart = false;
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
  final List<int> reviewModelItems = [];
  final List<int> reviewModelReportItems = [];
  int packId = 0;
  int supplierBranchId = 0;
  int quntity = 1;
  int cartCount = 0;
  List<int> radioPackItems = [];

  List<String> galleryImages = [];
  List<String> attributeImages = [];
  List<String> images = [];

  @override
  void onInit() {
    isLiked = false;
    addedToCart = false;

    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isLogin)
        .then((value) async {
      var isLogin = value!;
      if (isLogin) {

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
            addToRecent(productId, Get.locale!.languageCode);
            MySharedPreferences.instance
                .getIntValuesSF(SharedPreferencesKeys.loginLogId)
                .then((value) async {
              loginLogId = value!;
            });
          });
        });

      }
    });


    super.onInit();
  }

  Future<void> addToRecent(productId, language) async {
    await api
        .addToRecent(userId, productId, language)
        .then((value) {})
        .catchError((error) {
      print('error....$error');
    });
  }

  Future<void> getProductDetails(language) async {
    Helper.showLoading();
    attributeTypeArr = [];
    radioPackItems = [];
    attributeValueArray = [];
    images=[];
    galleryImages=[];
    attributeImages=[];
    await api
        .getProductDetailsMobile(productSlug, isLogin, userId, language)
        .then((value) {
      if (value.statusCode == 200) {
        productDetailData = value.data!;
        packId = productDetailData!.productData![0].productPack![0].id!;
        for (var i = 0;
            i < productDetailData!.productData![0].productPack!.length;
            i++) {
          radioPackItems
              .add(productDetailData!.productData![0].productPack![i].id!);
        }
        for(var i=0; i<productDetailData!.productData![0].productGallery!.length;i++){
          galleryImages.add(productDetailData!.productData![0].productGallery![i].largeImageUrl!);
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
        print('......${isLogin}....${productDetailData!.productData![0].isWhishlist}');
        if (isLogin) {
          if (productDetailData!.productData![0].isWhishlist == 1) {
            isLiked = true;
          }
        }
        if (productDetailData!.productAssociateAttribute != null) {
          for (var i = 0;
              i < productDetailData!.productAssociateAttribute!.length;
              i++) {
            if (productDetailData!.productAssociateAttribute![i].options !=
                null) {
              attributeTypeArr.add(productDetailData!
                  .productAssociateAttribute![i].attributeName!);
              if (productDetailData!.productAssociateAttribute![i].options![0]
                      .attributeOptionValue !=
                  null) {
                attributeValueArray.add(productDetailData!
                    .productAssociateAttribute![i]
                    .options![0]
                    .attributeOptionValue!);
              } else {
                attributeValueArray.add("");
              }
            }
            var a = AttributeModel();
            a.setPrimaryIndex = i;
            a.setSecondaryIndex = 0;
            attributeItems.add(a);
          }
          if (attributeTypeArr.length == 0) {
            isWithAttribute=false;
            images.addAll(galleryImages);
            getAttributeWithoutCombination(language, 0);
          } else {
            isWithAttribute=true;

            getAttributeCombination(language, 0);
          }
        } else {
          Helper.hideLoading(context);
          update();
        }

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
    print(
        "object${attributeTypeArr.toString()}....${attributeValueArray.toString()}");
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
      getAttributeWithoutCombination(language, 1);
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
          if (attributeData!.productQtyPackData != null) {
            packId = attributeData!.productQtyPackData![0].productPackId!;
            supplierBranchId =
                attributeData!.productQtyPackData![0].supplierBranchId!;
            for (var i = 0;
                i < attributeData!.productQtyPackData!.length;
                i++) {
              radioPackItems
                  .add(attributeData!.productQtyPackData![i].productPackId!);
            }
          }
          for(var i=0; i<attributeData!.galleryAndAttributeComArr!.length;i++){
            attributeImages.add(attributeData!.galleryAndAttributeComArr![i].largeImageUrl!);
          }
          print('.......${attributeImages.length}....${galleryImages.length}');
          images.addAll(attributeImages);
          images.addAll(galleryImages);
        } else {
          Helper.showGetSnackBar(value.message!, AppColors.errorColor);
        }

        update();
      }).catchError((error) {
        Helper.hideLoading(context);
        update();
        print('error....$error');
      });
    }
  }

  Future<void> getAttributeCombination(language, int i) async {
    if (i == 1) Helper.showLoading();
    final Map<String, dynamic> attrData = {
      "attribute_type": attributeTypeArr,
      "attribute_value": attributeValueArray
    };
    print('$attrData.....$productId....$packId');
    radioPackItems = [];
    attributeImages=[];
    await api
        .getItemIdByAttributeCombination(packId, productId, attrData, language)
        .then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        attributeData = value.data;
        if (attributeData!.productQtyPackData != null) {
          packId = attributeData!.productQtyPackData![0].productPackId!;
          supplierBranchId =
              attributeData!.productQtyPackData![0].supplierBranchId!;
          for (var i = 0; i < attributeData!.productQtyPackData!.length; i++) {
            radioPackItems
                .add(attributeData!.productQtyPackData![i].productPackId!);
          }

        }
        for(var i=0; i<attributeData!.galleryAndAttributeComArr!.length;i++){
          attributeImages.add(attributeData!.galleryAndAttributeComArr![i].largeImageUrl!);
        }
        print('.......${attributeImages.length}....${galleryImages.length}');
        images.addAll(attributeImages);
        images.addAll(galleryImages);
      } else {
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
      }

      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> getAttributeWithoutCombination(language, int i) async {
    if (i == 1) Helper.showLoading();
    print('....$productId....$packId');
    radioPackItems = [];
    await api.getProductSupplier(packId, productId, language).then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        attributeData = value.data;
        if (attributeData!.productQtyPackData != null) {
          packId = attributeData!.productQtyPackData![0].productPackId!;
          supplierBranchId =
              attributeData!.productQtyPackData![0].supplierBranchId!;

          for (var i = 0; i < attributeData!.productQtyPackData!.length; i++) {
            radioPackItems
                .add(attributeData!.productQtyPackData![i].productPackId!);
          }
        }
      } else {
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
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
        Helper.showGetSnackBar(value.message!, AppColors.successColor);
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
      }
    }).catchError((error) {
      print('error....$error');
    });
  }

  Future<void> addReviewHelpful(reviewId, language, index) async {
    Helper.showLoading();
    await api
        .addReviewHelpful(token, userId, productId, reviewId, language)
        .then((value) {
      if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        Helper.hideLoading(context);
        reviewMessage = value.message!;
        reviewModelItems.add(index);
      }
      update();
    }).catchError((error) {
      print('error....$error');
    });
  }

  Future<void> addReviewReport(reviewId, language, index) async {
    Helper.showLoading();
    await api
        .addReviewReportAbuse(token, userId, productId, reviewId,
            titleController.text, descriptionController.text, language)
        .then((value) {
      if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        Helper.hideLoading(context);
        reportMessage = value.message!;
        reviewModelReportItems.add(index);
      }
      update();
    }).catchError((error) {
      print('error....$error');
    });
  }

  Future<void> addToCart(productItemId, supplierId, language) async {
    addressList = [];
    Helper.showLoading();
    print(
        'add......$productId,$packId,$productItemId,$userId,$quntity,$addressId,$supplierId,$supplierBranchId');
    await api
        .addToCart(token, productId, packId, productItemId, userId, quntity,
            addressId, supplierId, supplierBranchId, language)
        .then((value) {
      if (value.statusCode == 200) {
        addedToCart = true;
        cartCount = value.data!.cartTotalItems!;
        Helper.hideLoading(context);
        _showDialog();
      } else if (value.statusCode == 401) {
        addedToCart = false;
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        addedToCart = false;
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
      }
      update();
    }).catchError((error) {
      print('error....$error');
    });
  }
  Future<void> addToCartBuyNow(productItemId, supplierId, language) async {
    addressList = [];
    Helper.showLoading();
    print(
        'add......$productId,$packId,$productItemId,$userId,$quntity,$addressId,$supplierId,$supplierBranchId');
    await api
        .addToCart(token, productId, packId, productItemId, userId, quntity,
            addressId, supplierId, supplierBranchId, language)
        .then((value) {
      if (value.statusCode == 200) {
        addedToCart = true;
        cartCount = value.data!.cartTotalItems!;
        Helper.hideLoading(context);
     navigateTo(CartScreen(
          from: AppConstants.productDetail,
        ));
      //  _showDialog();
      } else if (value.statusCode == 401) {
        addedToCart = false;
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        addedToCart = false;
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
      }
      update();
    }).catchError((error) {
      print('error....$error');
    });
  }

  void _showDialog() async {
    await showDialog(
        context: context,
        builder: (_) {
          Future.delayed(Duration(milliseconds: 1500), () {
            Navigator.of(context).pop(true);
          });
          return Center(
              child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    width: 160,
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.appBarColor,
                        borderRadius: BorderRadius.circular(4)),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.checkmark_circle_fill,
                          color: Colors.white,
                        ),
                        10.widthBox,
                        Text(
                          'Added To Cart',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )));
        });
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
        //   Get.delete<ProductDetailController>();
        Navigator.of(context).pop(true);
        /* Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                      productId: productId,
                      productslug: productSlug,
                    )));*/
        MySharedPreferences.instance
            .getStringValuesSF(SharedPreferencesKeys.address)
            .then((value) async {
          address = value!;
          update();
        });
        MySharedPreferences.instance
            .getStringValuesSF(SharedPreferencesKeys.addressId)
            .then((value) async {
          if (value != null) addressId = value;
          update();
        });
        // update();
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

  void navigateToProductDetailScreen(int productId, String productSlug) {
    Get.delete<ProductDetailController>();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
                productId: productId, productslug: productSlug))).then((value) {
      if (value) {
        MySharedPreferences.instance
            .getStringValuesSF(SharedPreferencesKeys.address)
            .then((value) async {
          address = value!;
          update();
        });
      }
    });
  }

  final List<String> items = ['Sofa', 'Bed'];

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

  void exitScreen(CartController cartController,bool fromDeepLink) {

   if(fromDeepLink){
     Get.deleteAll();
     Get.offAll(DrawerScreen());
   } else{
     Get.delete<ProductDetailController>();
    cartController.update();
    Navigator.of(context).pop(true);}
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
