part of view;

typedef OverlayLoadingFunc = VoidFutureCallBack;

abstract class ViewModel<T extends Controller> {
  final T controller = Get.find<T>();

  bool get isLoading => _loading;
  bool _loading = true;

  Future _init() async {
    await controller.loading;
    init();
  }

  @mustCallSuper
  Future init() async {
    _loading = false;
    updateView();
  }

  @mustCallSuper
  Future dispose() async {}

  bool _overlayLoading = false;
  bool get isOverlayLoading => _overlayLoading;

  Future overlayLoading(VoidFutureCallBack voidFutureCallBack) async {
    initOverlayLoading();
    await voidFutureCallBack();
    completedOverlayLoading();
  }

  void initOverlayLoading() {
    _overlayLoading = true;
    updateView();
  }

  void completedOverlayLoading() {
    _overlayLoading = false;
    updateView();
  }

  void updateView() {
    controller.update();
  }
}
