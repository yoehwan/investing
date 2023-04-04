import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:investing/controller/finviz_controller.dart';
import 'package:investing/view/view.dart';

const _selectorList =
    ".banner, .banners, .ads, .ad, .advert, .header, .navbar, .map-sidebar, .items-center, .info, .my-3, .mx-auto, .footer, #ic_mobileadhesion";

class FinVizViewModel extends ViewModel<FinVizController> {
  final Uri uri = Uri.parse("https://finviz.com/map.ashx?t=sec&st=d1");
  final List<ContentBlocker> contentBlockers = [
    ContentBlocker(
      trigger: ContentBlockerTrigger(
        urlFilter: ".*",
      ),
      action: ContentBlockerAction(
        type: ContentBlockerActionType.CSS_DISPLAY_NONE,
        selector: _selectorList,
      ),
    )
  ];
}
