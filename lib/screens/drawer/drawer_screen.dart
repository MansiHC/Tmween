import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmween/model/drawer_model.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

class DrawerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DrawerScreenState();
  }
}

class _DrawerScreenState extends State<DrawerScreen>
{

 late List<DrawerModel> _drawerModelList;

  @override
  void didChangeDependencies() {
    _values();
    super.didChangeDependencies();
  }

  Future<void> _values() async {
    _drawerModelList = <DrawerModel>[];

    _drawerModelList.add(DrawerModel(
        id: 14,
        image: Icons.person_outline,
        name: 'profile'));
    _drawerModelList.add(DrawerModel(
        id: 15,
        image: Icons.settings_outlined,
        name: 'settings'));
    _drawerModelList.add(DrawerModel(
        id: 16,
        image: Icons.logout,
        name: 'logOut'));


  }

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: _drawerModelList.length,
        itemBuilder: (context, index) => _drawerModelList[index]
            .hasList
            ? Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width / 3),
            child: Theme(
                data: Theme.of(context).copyWith(
                    accentColor: Colors.white,
                    unselectedWidgetColor: Colors.white),
                child: ListTileTheme(
                    minLeadingWidth: 0,
                    dense: true,
                    child: ExpansionTile(
                      iconColor: Colors.white,
                      initiallyExpanded:
                      index == 0 ? true : false,
                      backgroundColor: Colors.black12,
                      tilePadding: EdgeInsets.symmetric(
                          horizontal: 5, vertical: 0),
                      title: Text(_drawerModelList[index]
                          .name!,style: TextStyle(color: Colors.white),),
                      leading: Icon(
                        _drawerModelList[index].image,
                        color: Colors.white,
                        size: 25 ,
                      ),
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(left: 25),
                            itemCount: _drawerModelList[index]
                                .list!
                                .length,
                            itemBuilder: (context, index2) =>
                                InkWell(
                                    onTap: () {
                                      _openPage(index, index2);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          _drawerModelList[
                                          index]
                                              .list![index2]
                                              .image,
                                          color: Colors.white,
                                          size: 20
                                              ,
                                        ),
                                        10.widthBox
                                            ,
                                        Text(_drawerModelList[index]
                                            .list![index2]
                                            .name!,style: TextStyle(color: Colors.white),)
                                            ,
                                      ],
                                    )))
                      ],
                    ))))
            : InkWell(
            onTap: () {
              if (_drawerModelList[index].name!.compareTo(
                  'profile') ==
                  0) {
               /* Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Profile()));*/
              } else if (_drawerModelList[index].name!.compareTo(
                  'logOut') ==
                  0) {
                _logout(context);
              }
            },
            child: Row(
              children: [
                Icon(
                  _drawerModelList[index].image,
                  color: Colors.white,
                  size: 25,
                ),
                10.widthBox ,
               Text( _drawerModelList[index]
                    .name!,style: TextStyle(color: Colors.white),)
                    ,
              ],
            )));
  }

 void _logout(BuildContext context) {
   AlertDialog alertDialog = AlertDialog(
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
           Text('logOut')

         ])),
     content: Container(
         width: double.maxFinite,
         height: 70,
         child: Column(children: [
           Text('logOutMessage'),
           5.heightBox,
           Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               TextButton(
                 child: Text('no')
                     ,
                 onPressed: () {
                   setState(() {
                     Navigator.of(context).pop();
                   });
                 },
               ),
               TextButton(
                 child: Text('yes')
                     ,
                 onPressed: () async {
                    setState(()  {
                    /* MySharedPreferences.instance
                         .addBoolToSF(Strings.isLogin, false);
                     Navigator.of(context).pop();

                     Navigator.of(context).pushAndRemoveUntil(
                       FadeRoute(
                         page: Login(),
                       ),
                           (route) => false,
                     );*/
                   });
                 },
               ),
             ],
           )
         ])),
   );
   showDialog(context: context, builder: (_) => alertDialog);
 }

 void _openPage(int index, int index2) {

 }

}