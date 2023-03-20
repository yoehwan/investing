import 'package:dividends_manager/controller/news_controller.dart';
import 'package:dividends_manager/view/news_view/detail_view/news_detail_view.dart';
import 'package:dividends_manager/view/news_view/news_view_model.dart';
import 'package:dividends_manager/view/view.dart';
import 'package:dividends_manager/widget/news_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsView extends View<NewsViewModel, NewsController> {
  NewsView({super.key}) : super(viewModel: NewsViewModel());
  AppBar appBar() {
    return AppBar(
      title: const Text("News"),
      actions: [
        IconButton(
          onPressed: () {
            // Get.to(NewsSearchView());
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  Widget newsListView() {
    final list = viewModel.newsList;
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      onLoading: viewModel.onLoadingNews,
      onRefresh: viewModel.onRefresh,
      controller: viewModel.refreshController,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final news = list[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: NewsCard(
                  onTap: () {
                    Get.to(
                      NewsDetailView(news: news),
                    );
                  },
                  news: news,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget body() {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: appBar(),
        body: newsListView(),
      ),
    );
  }
}
