part of resizable_widget;

class ResizableScreen {
  /// Used by [ResizableWidget] to set and calculate the screen size.
  late double size;

  /// The percent size of the widget used on this screen.
  /// 
  /// The main widget will only use the screen1 [percentSize].
  double percentSize;

  /// The minimum size the user can resize from this screen.
  final double minSize;

  /// Used to fix the screen size when resizing the window (not the middle bar).
  /// 
  /// Fix only one screen at a time. Can not be used in both screens.
  final bool fixedSizeWhenResizingWindow;

  /// Called to obtain the child widget and build this screen.
  final Widget Function() screenBuilder;

  /// Use it to get this screen key/context and navigate: [key.currentContext].
  /// 
  /// Ex: Navigator.push(key.currentContext!, ...);
  final GlobalKey<NavigatorState> key;

  /// The initial value for the screen size.
  /// 
  /// It works on only one screen at a time.
  final double? beginningSize;

  ResizableScreen({
    required this.screenBuilder,
    this.minSize = 100,
    this.percentSize = 0.3,
    this.fixedSizeWhenResizingWindow = false,
    this.beginningSize,
  })  : key = GlobalKey<NavigatorState>(),
        _initialPercentSize = percentSize;

  late final double _initialPercentSize;

  /// Used by [ResizableWidget] to get the [percentSize] passed in the constructor.
  double get initialPercentSize => _initialPercentSize;

  /// Prefer use it instead of Navigator.pop(...);
  void pop() {
    if (key.currentState != null && key.currentContext != null) {
      if (key.currentState!.canPop()) {
        Navigator.pop(key.currentContext!);
      }
    }
  }

  /// Back to initial page.
  void popAll() {
    if (key.currentState != null && key.currentContext != null) {
      while (key.currentState!.canPop()) {
        Navigator.pop(key.currentContext!);
      }
    }
  }

  /// Check if can use Navigot.pop(...);
  bool canPop() {
    if (key.currentState != null) {
      return key.currentState!.canPop();
    }
    return false;
  }
}
