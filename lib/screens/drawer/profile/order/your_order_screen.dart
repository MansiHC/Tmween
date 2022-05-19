import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/your_order_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/order_listing_model.dart';
import 'package:tmween/screens/drawer/profile/order/order_container.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../../utils/views/custom_text_form_field.dart';

class YourOrderScreen extends StatelessWidget {
  late String language;
  final yourOrderController = Get.put(YourOrderController());

  bool fromSearch = false;

  Future<bool> _onWillPop(YourOrderController yourOrderController) async {
    yourOrderController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<YourOrderController>(
        init: YourOrderController(),
        builder: (contet) {
          yourOrderController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(yourOrderController),
              child: Scaffold(
                  body: Container(
                      color: Color(0xFFF2F2F2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              constraints: BoxConstraints(
                                  minWidth: double.infinity, maxHeight: 90),
                              color: AppColors.appBarColor,
                              padding: EdgeInsets.only(top: 20),
                              child: topView(yourOrderController)),
                          Expanded(child: _bottomView(yourOrderController))
                        ],
                      ))));
        });
  }

  Widget _bottomView(YourOrderController yourOrderController) {
    return yourOrderController.orders!.length == 0 &&
            !yourOrderController.isLoading &&
            !fromSearch
        ? _noOrderView(yourOrderController)
        : _orderList(yourOrderController);
  }

  void filterSearchResults(String query) {
    fromSearch = true;
    List<OrderData> dummySearchList = [];
    dummySearchList.addAll(yourOrderController.orderItems!);
    List<OrderData> dummyListData = [];
    if (query.isNotEmpty) {
      dummySearchList.forEach((item) {
        if (item.salesOrderItem![0].productName!
            .toLowerCase()
            .contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      yourOrderController.orders = dummyListData;
      yourOrderController.update();
      return;
    } else {
      yourOrderController.orders = yourOrderController.orderItems!;
      yourOrderController.update();
    }
  }

  Widget _orderList(YourOrderController yourOrderController) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo is ScrollEndNotification &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            if (yourOrderController.next != 0) {
              yourOrderController.loadMore(language);
            }
          }

          return false;
        },
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CustomTextFormField(
                  isDense: true,
                  controller: yourOrderController.searchController,
                  keyboardType: TextInputType.text,
                  hintText: LocaleKeys.searchAllOrder.tr,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (term) {
                    yourOrderController.getSearchOrderList(term, language);
                    FocusScope.of(yourOrderController.context).unfocus();
                  },
                  onChanged: (value) {
                    // filterSearchResults(value);
                    yourOrderController.update();
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightGrayColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightGrayColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightGrayColor),
                    ),
                    isDense: true,
                    hintText: LocaleKeys.searchProducts.tr,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFF686868),
                      size: 32,
                    ),
                    suffixIcon:
                        yourOrderController.searchController.text.length > 0
                            ? IconButton(
                                onPressed: () {
                                  yourOrderController.searchController.clear();
                                  yourOrderController.orders!.clear();
                                  yourOrderController.orders!
                                      .addAll(yourOrderController.orderItems!);
                                  yourOrderController.update();
                                },
                                icon: Icon(
                                  CupertinoIcons.clear_circled_solid,
                                  color: AppColors.primaryColor,
                                  size: 24,
                                ))
                            : SizedBox(),
                  ),
                  validator: (value) {
                    return null;
                  }),
              20.heightBox,
              Expanded(
                  child: SingleChildScrollView(
                      child: fromSearch &&
                              yourOrderController.orders!.length == 0
                          ? Center(
                              child: Text(
                              LocaleKeys.noRecords.tr,
                              style: TextStyle(
                                  color: Color(0xFF414141),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ))
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: yourOrderController.orders!.length,
                              itemBuilder: (context, index) {
                                return OrderContainer(
                                    order: yourOrderController.orders![index],
                                    index: index,
                                    length: yourOrderController.orders!.length);
                              })))
            ],
          ),
        ));
  }

  Widget _noOrderView(YourOrderController yourOrderController) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical:
                MediaQuery.of(yourOrderController.context).size.height / 3),
        child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFD7D7D7))),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                5.heightBox,
                Text(
                  LocaleKeys.waitingToDeliver.tr,
                  style: TextStyle(fontSize: 16, color: Color(0xFF737373)),
                ),
                5.heightBox,
                Text(
                  LocaleKeys.shopProductsFrom.tr,
                  style: TextStyle(fontSize: 14, color: Color(0xFFBEBEBE)),
                ),
                10.heightBox,
                CustomButton(
                    text: LocaleKeys.startShopping,
                    fontSize: 18,
                    onPressed: () {
                      yourOrderController.navigateToDashboardScreen();
                    }),
                5.heightBox
              ],
            ))));
  }

  Widget topView(YourOrderController yourOrderController) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Stack(
          children: [
            Align(
                alignment: language == 'ar'
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: ClipOval(
                  child: Material(
                    color: Colors.white, // Button color
                    child: InkWell(
                      onTap: () {
                        yourOrderController.exitScreen();
                      },
                      child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Icon(
                            Icons.keyboard_arrow_left_sharp,
                            color: Colors.black,
                          )),
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.yourOrders.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
