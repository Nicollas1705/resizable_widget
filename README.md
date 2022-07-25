# resizable_widget

This package provides a widget that splits screen into two parts where these parts can be resized. 

<br>
<img WIDTH="60%" src="https://user-images.githubusercontent.com/84534787/120998591-a95c6980-c7a1-11eb-9435-7d7587f0b32b.png">
<br>
<br>


## Example

![Resizable widget example](https://user-images.githubusercontent.com/58062436/157943179-9942847e-3fa4-476a-9a47-e1ef8dacfe8a.gif)

[Example code](https://github.com/Nicollas1705/resizable_widget_example)


## Usage

1. Add the dependency into pubspec.yaml.

```yaml
dependencies:
  resizable_widget:
    git:
      url: https://github.com/Nicollas1705/resizable_widget
      ref: master
```

2. Import the library:

```dart
import 'package:resizable_widget/resizable_widget.dart';
```

3. Create the and initialize the ResizableController:

```dart
final resizableController = ResizableController(sizeSeparator: 600);
```

4. Create both screens:

```dart
late final ResizableScreen screen1;
late final ResizableScreen screen2;
```

5. Initialize both screens (initState):

```dart
screen1 = ResizableScreen(
  screenBuilder: () => Scaffold(
    appBar: AppBar(title: const Text("Screen 1")),
  ),
);
screen2 = ResizableScreen(
  screenBuilder: () => Scaffold(
    appBar: AppBar(title: const Text("Screen 2")),
  ),
);
```

6. Use the ResizableWidget:

The [resizableBarBackgroundColor] is just to visualize the resizable bar.

```dart
ResizableWidget(
  controller: resizableController,
  screen1: screen1,
  screen2: screen2,
  resizableBarBackgroundColor: Colors.amberAccent,
);
```

### Result

![Resizable widget - Simple example](https://user-images.githubusercontent.com/58062436/157949243-7e4a1116-eb28-431d-b4c2-92396e810142.gif)


### Example code result:

```dart
class SimpleExample extends StatefulWidget {
  const SimpleExample({Key? key}) : super(key: key);

  @override
  State<SimpleExample> createState() => _SimpleExampleState();
}

class _SimpleExampleState extends State<SimpleExample> {
  final resizableController = ResizableController(sizeSeparator: 600);
  late final ResizableScreen screen1;
  late final ResizableScreen screen2;

  @override
  void initState() {
    super.initState();

    screen1 = ResizableScreen(
      screenBuilder: () => Scaffold(
        appBar: AppBar(title: const Text("Screen 1")),
      ),
    );
    screen2 = ResizableScreen(
      screenBuilder: () => Scaffold(
        appBar: AppBar(title: const Text("Screen 2")),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResizableWidget(
      controller: resizableController,
      screen1: screen1,
      screen2: screen2,
      resizableBarBackgroundColor: Colors.amberAccent,
    );
  }
}
```


## Controller, screens and ResizableWidget

Just a simple view about the controller and the screens. These will be discussed in more detail later.

The [ResizableController] will be responsible to calculate the sizes, the resize controll and give some informations about the current sizes state.

The [ResizableScreen] will be responsible to set each single screen sizes and give some [Navigator] methods (like canPop() or popAll()).

The [ResizableWidget] will be responsible for building the split screen and separate the navigation for each of them.


## ResizableController in details

The [ResizableController] can be instantiated with some parameters.

### ResizableController constructor parameters

<table>
  <tr>
    <th>
      Parameter
    </th>
    <th>
      Description
    </th>
  </tr>
  <tr>
    <td>
      sizeSeparator [double]
    </td>
    <td>
      Compare to the screen size to define if it is single or multi screen. If (availableSize < sizeSeparator), shows only the screen1; else, shows both screens. Default is 800.
    </td>
  </tr>
  <tr>
    <td>
      isResizable [bool]
    </td>
    <td>
      Enable/disable the resizable widget bar. Default is true.
    </td>
  </tr>
  <tr>
    <td>
      splitDirection [Axis]
    </td>
    <td>
      The direction of split screens. Default is [Axis.horizontal]. If is [Axis.horizontal], shows side by side screens; if [Axis.vertical], shows screens up and down.
    </td>
  </tr>
</table>


### splitDirection example:

```dart
final resizableController = ResizableController(
  sizeSeparator: 300, // Optional
  splitDirection: Axis.vertical,
);
```

![splitDirection example](https://user-images.githubusercontent.com/58062436/157986178-36781e58-8940-45b0-8d20-876c84c90979.gif)


### ResizableController methods

<table>
  <tr>
    <th>
      Method
    </th>
    <th>
      Description
    </th>
  </tr>
  <tr>
    <td>
      maxWindowSize [double]
    </td>
    <td>
      Get method: the maximum widget size available.
    </td>
  </tr>
  <tr>
    <td>
      maxSize [double]
    </td>
    <td>
      Get method: the maximum available size of both screens. If is showing both screens, it will be the sum if them, if not showing, it will be the same as [maxWindowSize]. 
    </td>
  </tr>
  <tr>
    <td>
      resizableBarThickness [double]
    </td>
    <td>
      Get method: the resizable bar thickness (used to calculate some case).
    </td>
  </tr>
  <tr>
    <td>
      isResizing [bool]
    </td>
    <td>
      Get method: return true when resizing the screens (the middle bar resize).
    </td>
  </tr>
  <tr>
    <td>
      isShowingBothScreens [bool]
    </td>
    <td>
      Get method: check if both screens are being shown.
    </td>
  </tr>
  <tr>
    <td>
      showScreen2 [bool]
    </td>
    <td>
      Set method: you can use to show/hide the second screen (show only if it has enough space).
    </td>
  </tr>
</table>


#### showScreen2 example:

```dart
screen1 = ResizableScreen(
  screenBuilder: () => Scaffold(
    appBar: AppBar(
      title: const Text("Screen 1"),
      actions: [
        IconButton(
          onPressed: () {
            resizableController.showScreen2 = !resizableController.showScreen2;
          },
          icon: const Icon(Icons.block),
        )
      ],
    ),
  ),
);
```

![showScreen2 example](https://user-images.githubusercontent.com/58062436/157976095-5372f441-5779-4791-82a9-2465b30a32e7.gif)


## ResizableScreen in details

The [ResizableScreen] can be instantiated with some parameters.


### ResizableScreen constructor parameters

<table>
  <tr>
    <th>
      Parameter
    </th>
    <th>
      Description
    </th>
  </tr>
  <tr>
    <td>
      screenBuilder [Widget Function()]
    </td>
    <td>
      Required: called to obtain the child widget and build this screen.
    </td>
  </tr>
  <tr>
    <td>
      percentSize [double]
    </td>
    <td>
      The percent size of the widget used on the screen. The main widget will only use the percentSize of the first screen. Min = 0; max = 1.
    </td>
  </tr>
  <tr>
    <td>
      minSize [double]
    </td>
    <td>
      The minimum size the user can resize from this screen. Default is 100.
    </td>
  </tr>
  <tr>
    <td>
      beginningSize [double]
    </td>
    <td>
      The initial value for the screen size. It works on only one screen at a time (just one screen can be beginningSize = true).
    </td>
  </tr>
  <tr>
    <td>
      fixedSizeWhenResizingWindow [bool]
    </td>
    <td>
      Used to fix the screen size when resizing the window (not the middle bar). Fix only one screen at a time. Can not be used in both screens.
    </td>
  </tr>
</table>


#### percentSize example:

```dart
screen1 = ResizableScreen(
  percentSize: 0.5, // Half of the available size
  screenBuilder: () => Scaffold(
    appBar: AppBar(title: const Text("Screen 1")),
  ),
);
```

![percentSize example](https://user-images.githubusercontent.com/58062436/157976572-3ba677dd-2f09-46bc-933c-a9b3ca43b99c.png)


#### minSize example:

```dart
screen1 = ResizableScreen(
  minSize: 300,
  screenBuilder: () => Scaffold(
    appBar: AppBar(title: const Text("Screen 1")),
    body: Container(
      width: 300, // Same as the minSize
      color: Colors.redAccent,
    ),
  ),
);
```

![minSize example](https://user-images.githubusercontent.com/58062436/157978015-05542965-f638-4733-b515-d31062eff520.gif)


#### fixedSizeWhenResizingWindow example:

```dart
screen1 = ResizableScreen(
  fixedSizeWhenResizingWindow: true,
  screenBuilder: () => Scaffold(
    appBar: AppBar(title: const Text("Screen 1")),
  ),
);
```

![fixedSizeWhenResizingWindow example](https://user-images.githubusercontent.com/58062436/157979360-e47650d5-b19a-48ad-aa4b-e5de742c1e2e.gif)


### ResizableScreen methods and properties

<table>
  <tr>
    <th>
      Methods/Properties
    </th>
    <th>
      Description
    </th>
  </tr>
  <tr>
    <td>
      key [GlobalKey]
    </td>
    <td>
      Property: Use it to get the screen key/context and navigate: [key.currentContext]. Example: Navigator.push(key.currentContext!, ...);
    </td>
  </tr>
  <tr>
    <td>
      pop() [void]
    </td>
    <td>
      Method: prefer use it to pop the screen (instead of Navigator.pop(...);). 
    </td>
  </tr>
  <tr>
    <td>
      popAll() [void]
    </td>
    <td>
      Method: use it to pop all the screens and back to the initial screen.
    </td>
  </tr>
  <tr>
    <td>
      canPop() [bool]
    </td>
    <td>
      Method: check if Navigator.pop(...) method can be used on the screen.
    </td>
  </tr>
</table>


## ResizableWidget in details

The [ResizableWidget] constructor will needs (required) the controller [ResizableController] and 2 screens [ResizableScreen] to build itself.

The screen1 is the first screen shown. The screen2 is the second screen shown.

You can also customize the resizable bar (middle bar) with the [resizableBarDecoration] parameter, or simply setting a background color with the [resizableBarBackgroundColor] parameter. Or even the resize icon button with [resizableIconColor].

If on a mobile, set [dragOnlyOnLongPress] as true to a better user experience.


### dragOnlyOnLongPress example:

```dart
@override
Widget build(BuildContext context) {
  return ResizableWidget(
    dragOnlyOnLongPress: true,
    controller: resizableController,
    screen1: screen1,
    screen2: screen2,
    resizableBarBackgroundColor: Colors.amberAccent,
  );
}
```

![dragOnlyOnLongPress example](https://user-images.githubusercontent.com/58062436/157983573-54102071-fe1b-4f28-8107-b87b4724852c.gif)


## Note

This package was developed to be used on any platform, adapting to the window (or available) size.
