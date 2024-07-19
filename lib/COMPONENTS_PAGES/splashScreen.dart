import 'package:flutter/material.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeIn,
    );

    _controller!.forward();

    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 3), () {});
    print('SplashScreen Running');
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animation!,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/App_logo.jpg'),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            FadeTransition(
              opacity: _animation!,
              child: Text('Welcome Back to Diabetes Care Taker'),
            ),
          ],
        ),
      ),
    );
  }
}
