import 'dart:async';

import 'package:investing/controller/stock_controller.dart';
import 'package:investing/model/ticker.dart';
import 'package:investing/view/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockSearchViewModel extends ViewModel<StockController> {
  List<Ticker> get stockList => controller.watchList;
  final List<Ticker> searchedList = [];
  final TextEditingController queryCntroller = TextEditingController();
  final RxString rxQuery = RxString("");
  late final Worker _queryWoker;

  @override
  Future init() {
    _queryWoker = debounce(rxQuery, (query) {
      searchStock(query);
    }, time: const Duration(milliseconds: 1000));
    return super.init();
  }

  @override
  Future dispose() {
    _queryWoker.dispose();
    return super.dispose();
  }

  void searchStock(String query) async {
    if (query.isEmpty) {
      return;
    }
    await overlayLoading(() async {
      final list = await controller.searchStock(query);
      searchedList.clear();
      searchedList.addAll(list);
    });
    updateView();
  }

  Future toggleBookmark(Ticker stock) {
    return controller.toggleFvoriteStock(stock);
  }
}
