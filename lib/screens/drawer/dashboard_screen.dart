import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_text_form_field.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends State<DashboardScreen> {
  late BuildContext _context;
  bool _isLoading = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _context = context;
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: AppColors.appBarColor,
            centerTitle: false,
            titleSpacing: 0.0,
            title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'East delivery in 1 day*',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: AppColors.primaryColor,
                      ),
                      Expanded(
                          child: Text(
                        '1999 Bluff Street MOODY Alabama - 35004',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )),
                    ],
                  ),
                ]),
            actions: [
              CircleAvatar(
                radius: 20,
                child: Icon(
                  Icons.account_circle,
                  size: 40,
                ),
                backgroundColor: CupertinoColors.white,
              ),
              20.widthBox
            ],
            elevation: 0.0,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: const <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Text(
                    'Drawer Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Messages'),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Profile'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ],
            ),
          ),
          body: Column(
            children:[
              Container(color: AppColors.appBarColor,child:
              Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 10,left: 20,right:20),
                  child: CustomTextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      hintText: "Search for products...",
                      textInputAction: TextInputAction.search,
                      onSubmitted: (term) {
                        FocusScope.of(context).unfocus();
                      },
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.primaryColor,
                      ),
                      validator: (value) {
                        return null;
                      }))),
              _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    backgroundColor: AppColors.primaryColor,
                  ))
                : ListView(
                    shrinkWrap: true,
                    children: [],
                  ),
          ]),
        ));
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
        context: _context,
        builder: (_) => AlertDialog(
              contentPadding: EdgeInsets.all(10),
              title: Container(
                  width: double.maxFinite,
                  height: 250,
                  child: Row(children: [
                    Image.asset(
                      ImageConstanst.logo,
                      height: 100,
                      width: 100,
                    ),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Text('exitText'),
                  ])),
              content: Container(
                  width: double.maxFinite,
                  height: 70,
                  child: Column(children: [
                    Text('sureText'),
                    5.heightBox,
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      TextButton(
                        child: Text('no'),
                        onPressed: () {
                          setState(() {
                            Navigator.of(_context).pop(false);
                          });
                        },
                      ),
                      TextButton(
                        child: Text('yes'),
                        onPressed: () {
                          setState(() {
                            SystemNavigator.pop();
                          });
                        },
                      ),
                    ])
                  ])),
            ));
  }
}
