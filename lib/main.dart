import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animated Stepper',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.grey.shade700,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
      home: const AnimatedStepper(),
    );
  }
}

class AnimatedStepper extends StatefulWidget {
  const AnimatedStepper({super.key});

  @override
  State<AnimatedStepper> createState() => _AnimatedStepperState();
}

class _AnimatedStepperState extends State<AnimatedStepper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  int _currentValue = 1;
  bool _isIncrementing = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _increment() {
    setState(() {
      _isIncrementing = true;
      _currentValue++;
    });
    _controller.forward(from: 0);
  }

  void _decrement() {
    setState(() {
      _isIncrementing = false;
      _currentValue--;
    });
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Stepper'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              iconSize: 40,
              onPressed: _currentValue > 0 ? _decrement : null,
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(
                        0,
                        _animation.value * 50 * (_isIncrementing ? -3 : 3),
                      ),
                      child: Opacity(
                        opacity: 1 - _animation.value,
                        child: Text(
                          '${_isIncrementing ? _currentValue - 1 : _currentValue + 1}',
                          style: const TextStyle(
                            fontSize: 50,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: _animation.value,
                      child: Text(
                        '$_currentValue',
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: const Icon(Icons.add),
              iconSize: 40,
              onPressed: _increment,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

