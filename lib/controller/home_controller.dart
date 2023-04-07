import 'package:investing/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:investing/repo/stock/stock_repo.dart';

class HomeController extends Controller<StockRepo> {
  HomeController(super.repo);
  final PageController pageController = PageController(keepPage: true);
  int _currentPage = 0;

  int get currentPage => _currentPage;
  void _pageControllerListener() {
    final page = pageController.page;
    if (page != null) {
      _currentPage = page.round();
      update();
    }
  }

  @override
  void onReady() {
    pageController.addListener(_pageControllerListener);
    super.onReady();
  }
}
