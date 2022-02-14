import 'package:flutter/cupertino.dart';

import '../model/deals_of_the_day_model.dart';
import '../model/select_category_model.dart';
import '../model/sold_by_tmween_model.dart';

class SoldByTmweenProvider extends ChangeNotifier{

  late BuildContext context;

  TextEditingController searchController = TextEditingController();

  List<SoldByTmweenModel> soldByTmweens = const <SoldByTmweenModel>[
    const SoldByTmweenModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
    const SoldByTmweenModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
    const SoldByTmweenModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
    const SoldByTmweenModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
  ];
}