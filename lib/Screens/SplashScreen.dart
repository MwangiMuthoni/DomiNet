import 'package:flutter/material.dart';
import '../Auth/Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _loadingController;
  late AnimationController _backgroundController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _loadingOpacityAnimation;
  late Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _loadingController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Setup animations
    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    ));

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));

    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_textController);

    _loadingOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_loadingController);

    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_backgroundController);

    // Start animations sequence
    _startAnimations();

    // Navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _backgroundController.forward();
    _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 800));
    _textController.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    _loadingController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _loadingController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(const Color(0xAA1A1B1E), const Color(0xFF1A1B1E), _backgroundAnimation.value)!,
                  Color.lerp(const Color(0xFF1A1B1E), const Color(0xFF0F1011), _backgroundAnimation.value)!,
                ],
              ),
            ),
            child: Stack(
              children: [
                // Animated background circles
                ...List.generate(3, (index) =>
                    AnimatedBuilder(
                      animation: _backgroundController,
                      builder: (context, child) {
                        return Positioned(
                          top: 100.0 + (index * 200.0) + (50 * _backgroundAnimation.value),
                          left: -100.0 + (index * 100.0) + (30 * _backgroundAnimation.value),
                          child: Opacity(
                            opacity: 0.1 * _backgroundAnimation.value,
                            child: Container(
                              width: 200 + (index * 50.0),
                              height: 200 + (index * 50.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ),

                // Main content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo with animations
                      AnimatedBuilder(
                        animation: _logoController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _logoScaleAnimation.value,
                            child: Opacity(
                              opacity: _logoOpacityAnimation.value,
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color(0xFFF15E33).withOpacity(0.3),
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFF15E33).withOpacity(0.2),
                                      blurRadius: 25,
                                      spreadRadius: 5,
                                      offset: const Offset(0, 8),
                                    ),
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 15,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                   child: Image.asset(
                                  'assets/img/logo.png',
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.contain,
                                ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 32),

                      // Text animations
                      SlideTransition(
                        position: _textSlideAnimation,
                        child: FadeTransition(
                          opacity: _textOpacityAnimation,
                          child: const Column(
                            children: [
                              Text(
                                'Domain Connect',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Kenya\'s Premier Domain Marketplace',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 48),

                      // Loading indicator with animation
                      FadeTransition(
                        opacity: _loadingOpacityAnimation,
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 3,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Loading...',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom text
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: FadeTransition(
                    opacity: _loadingOpacityAnimation,
                    child: const Text(
                      'Connecting domains, empowering businesses',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}