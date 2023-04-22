import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WidgetTypes? _selectedType = WidgetTypes.animatedAlign;
  AnimationFunctions? _selectedFunction = AnimationFunctions.bounceIn;
  bool _animationRunning = false;

  AlignmentGeometry _alignment = Alignment.topCenter;
  Color _color = Colors.black;
  double _width = 50;
  double _height = 50;
  EdgeInsetsGeometry _padding = const EdgeInsets.all(0);
  double _borderRadius = 0;
  double _opacity = 1;
  double _size = 64;
  double _elevation = 0;
  List<String> listItems = <String>["First", "Second", "Third"];
  TextStyle _style = const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.normal,
      fontFamily: "Tahoma",
      color: Colors.blue);
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Select a widget to animate",
          style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 250,
          child: DropdownButton<WidgetTypes>(
              value: _selectedType,
              isExpanded: true,
              items: WidgetTypes.values
                  .map((item) => DropdownMenuItem(
                      key: ValueKey(item.name),
                      value: item,
                      child: Text(item.name)))
                  .toList(),
              onChanged: (val) => {
                    setState(() {
                      _selectedType = val;
                    })
                  }),
        ),
        const SizedBox(height: 20),
        Text(
          "Select an animation function",
          style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 250,
          child: DropdownButton<AnimationFunctions>(
              value: _selectedFunction,
              isExpanded: true,
              items: AnimationFunctions.values
                  .map((item) => DropdownMenuItem(
                      value: item,
                      key: ValueKey(item.name),
                      child: Text(item.name)))
                  .toList(),
              onChanged: (val) => {
                    setState(() {
                      _selectedFunction = val;
                    })
                  }),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: _animationRunning ? null : _startAnimation,
            child: _animationRunning
                ? const SizedBox(
                    height: 20, width: 20, child: CircularProgressIndicator())
                : const Text("Animate it!")),
        const SizedBox(height: 10),
        Center(child: _widgetFactory(_selectedType, _selectedFunction))
      ],
    ));
  }

  Future _startAnimation() async {
    setState(() {
      _animationRunning = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _alignment = Alignment.centerRight;
      _color = Colors.green;
      _width = 250;
      _height = 150;
      _padding = const EdgeInsets.only(right: 10);
      _borderRadius = 25;
      _opacity = 0.25;
      _size = 128;
      _elevation = 10;
      _style = const TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.bold,
          fontFamily: "Arial Black",
          color: Colors.black);
      _crossFadeState = CrossFadeState.showSecond;
    });

    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _alignment = Alignment.bottomCenter;
      _color = Colors.yellow;
      _width = 200;
      _height = 200;
      _padding = const EdgeInsets.only(bottom: 20);
      _borderRadius = 0;
      _opacity = 0.75;
      _size = 96;
      _elevation = 0;
      _style = const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.normal,
          fontFamily: "Tahoma",
          color: Colors.blue);
      _crossFadeState = CrossFadeState.showFirst;
    });

    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _alignment = Alignment.centerLeft;
      _color = Colors.blue;
      _width = 150;
      _height = 250;
      _padding = const EdgeInsets.only(left: 30);
      _borderRadius = 200;
      _opacity = 0.05;
      _size = 48;
      _elevation = 20;
      _style = const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          fontFamily: "Verdana",
          color: Colors.red);
      _crossFadeState = CrossFadeState.showSecond;
    });

    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _alignment = Alignment.topCenter;
      _color = Colors.black;
      _width = 150;
      _height = 250;
      _padding = const EdgeInsets.all(0);
      _borderRadius = 0;
      _opacity = 1;
      _size = 96;
      _elevation = 0;
      _style = const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.normal,
          fontFamily: "Tahoma",
          color: Colors.blue);
      _crossFadeState = CrossFadeState.showFirst;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _animationRunning = false;
    });
  }

  Widget _widgetFactory(WidgetTypes? type, AnimationFunctions? function) {
    if (type == null || function == null) {
      return const Center(child: Text("Please select a widget!"));
    }

    switch (type) {
      case WidgetTypes.animatedAlign:
        return Container(
            color: Colors.grey,
            width: 300,
            height: 300,
            child: AnimatedAlign(
                curve: _convertToCurve(function),
                // change alignment setting to trigger the animation
                alignment: _alignment,
                duration: const Duration(seconds: 1),
                child:
                    Container(color: Colors.black, height: 100, width: 100)));
      case WidgetTypes.animatedContainer:
        return AnimatedContainer(
            curve: _convertToCurve(function),
            // change alignment, padding, width, height, color, or border radius setting to trigger the animation
            padding: _padding,
            alignment: _alignment,
            width: _width,
            height: _height,
            decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(_borderRadius)),
            duration: const Duration(seconds: 1),
            child: Container());
      case WidgetTypes.animatedCrossFade:
        return AnimatedCrossFade(
            firstCurve: _convertToCurve(function),
            secondCurve: _convertToCurve(function),
            firstChild: const SizedBox(
                width: 100, height: 100, child: Card(color: Colors.blueGrey)),
            secondChild: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(100)))),
            // change crossFadeState to trigger the animation
            crossFadeState: _crossFadeState,
            duration: const Duration(seconds: 1));
      case WidgetTypes.animatedDefaultTextStyle:
        return Center(
            child: AnimatedDefaultTextStyle(
                curve: _convertToCurve(function),
                duration: const Duration(seconds: 1),
                // change style to trigger the animation
                style: _style,
                child: const Text("Test")));
      case WidgetTypes.animatedOpacity:
        return AnimatedOpacity(
            // change opacity to trigger the animation
            opacity: _opacity,
            curve: _convertToCurve(function),
            duration: const Duration(seconds: 1),
            child: Container(width: 200, height: 200, color: Colors.black));
      case WidgetTypes.animatedPhysicalModel:
        return AnimatedPhysicalModel(
            curve: _convertToCurve(function),
            shape: BoxShape.rectangle,
            // change elevation to trigger the animation
            elevation: _elevation,
            color: Colors.white,
            animateShadowColor: true,
            shadowColor: Colors.black,
            duration: const Duration(seconds: 1),
            animateColor: true,
            child:
                Container(color: Colors.blueAccent, width: 100, height: 100));
      case WidgetTypes.animatedPositioned:
        return SizedBox(
          width: 300,
          height: 300,
          child: Stack(children: [
            AnimatedPositioned(
                // change width or height to trigger the animation
                width: _width,
                height: _height,
                curve: _convertToCurve(function),
                duration: const Duration(seconds: 1),
                child: Container(color: Colors.black))
          ]),
        );
      case WidgetTypes.animatedSize:
        return AnimatedSize(
            curve: _convertToCurve(function),
            duration: const Duration(seconds: 1),
            // change size to trigger the animation
            child: Icon(Icons.check_circle, size: _size, color: Colors.green));
    }
  }

  Curve _convertToCurve(AnimationFunctions function) {
    switch (function) {
      case AnimationFunctions.bounceIn:
        return Curves.bounceIn;
      case AnimationFunctions.bounceInOut:
        return Curves.bounceInOut;
      case AnimationFunctions.bounceOut:
        return Curves.bounceOut;
      case AnimationFunctions.decelerate:
        return Curves.decelerate;
      case AnimationFunctions.ease:
        return Curves.ease;
      case AnimationFunctions.easeIn:
        return Curves.easeIn;
      case AnimationFunctions.easeInBack:
        return Curves.easeInBack;
      case AnimationFunctions.easeInCirc:
        return Curves.easeInCirc;
      case AnimationFunctions.easeInCubic:
        return Curves.easeInCubic;
      case AnimationFunctions.easeInCubicEmphasized:
        return Curves.easeInOutCubicEmphasized;
      case AnimationFunctions.easeInExpo:
        return Curves.easeInExpo;
      case AnimationFunctions.easeInOut:
        return Curves.easeInOut;
      case AnimationFunctions.easeInOutBack:
        return Curves.easeInOutBack;
      case AnimationFunctions.easeInOutCirc:
        return Curves.easeInOutCirc;
      case AnimationFunctions.easeInOutCubic:
        return Curves.easeInOutCubic;
      case AnimationFunctions.easeInOutQuart:
        return Curves.easeInOutQuart;
      case AnimationFunctions.easeInOutQuint:
        return Curves.easeInOutQuint;
      case AnimationFunctions.easeInOutSine:
        return Curves.easeInOutSine;
      case AnimationFunctions.easeOut:
        return Curves.easeOut;
      case AnimationFunctions.easeOutBack:
        return Curves.easeOutBack;
      case AnimationFunctions.easeOutCirc:
        return Curves.easeOutCirc;
      case AnimationFunctions.easeOutCubic:
        return Curves.easeOutCubic;
      case AnimationFunctions.easeOutExpo:
        return Curves.easeOutExpo;
      case AnimationFunctions.easeOutQuart:
        return Curves.easeOutQuart;
      case AnimationFunctions.easeOutQuint:
        return Curves.easeOutQuint;
      case AnimationFunctions.easeOutSine:
        return Curves.easeOutSine;
      case AnimationFunctions.elasticInCurve:
        return Curves.elasticIn;
      case AnimationFunctions.elasticInOut:
        return Curves.elasticInOut;
      case AnimationFunctions.elasticOutCurve:
        return Curves.elasticOut;
      case AnimationFunctions.fastLinearToSlowEaseIn:
        return Curves.fastLinearToSlowEaseIn;
      case AnimationFunctions.fastOutSlowIn:
        return Curves.fastLinearToSlowEaseIn;
      case AnimationFunctions.linear:
        return Curves.linear;
      case AnimationFunctions.linearToEaseOut:
        return Curves.linearToEaseOut;
      case AnimationFunctions.slowMiddle:
        return Curves.slowMiddle;
    }
  }
}

enum WidgetTypes {
  animatedAlign,
  animatedContainer,
  animatedCrossFade,
  animatedDefaultTextStyle,
  animatedOpacity,
  animatedPhysicalModel,
  animatedPositioned,
  animatedSize
}

enum AnimationFunctions {
  bounceIn,
  bounceInOut,
  bounceOut,
  decelerate,
  ease,
  easeIn,
  easeInBack,
  easeInCirc,
  easeInCubic,
  easeInCubicEmphasized,
  easeInExpo,
  easeInOut,
  easeInOutBack,
  easeInOutCirc,
  easeInOutCubic,
  easeInOutQuart,
  easeInOutQuint,
  easeInOutSine,
  easeOut,
  easeOutBack,
  easeOutCirc,
  easeOutCubic,
  easeOutExpo,
  easeOutQuart,
  easeOutQuint,
  easeOutSine,
  elasticInCurve,
  elasticInOut,
  elasticOutCurve,
  fastLinearToSlowEaseIn,
  fastOutSlowIn,
  linear,
  linearToEaseOut,
  slowMiddle
}
