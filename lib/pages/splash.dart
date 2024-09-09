import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_wallpaper/pages/bottomnav.dart';
import 'package:page_transition/page_transition.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool ison = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 80), () {
      setState(() {
        ison = true;
      });
    });
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
            duration: const Duration(milliseconds: 1200),
            type: PageTransitionType.rightToLeft,
            child: const BottomNav(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Container(
        child: Stack(
          children: [
            AnimatedPositioned(
              right: ison ? 25 : 25,
              left: ison ? 25 : 25,
              top: ison ? 260 : -200,
              duration: const Duration(milliseconds: 1500),
              child: Container(
                width: 300,
                height: 3,
                color: Colors.white,
              ),
            ),
            AnimatedPositioned(
              right: ison ? 25 : 25,
              left: ison ? 25 : 25,
              bottom: ison ? 290 : -200,
              duration: const Duration(milliseconds: 1500),
              child: Container(
                width: 300,
                height: 3,
                color: Colors.white,
              ),
            ),
            AnimatedPositioned(
              top: ison ? 280 : -50,
              left: ison ? 60 : 60,
              duration: const Duration(milliseconds: 1500),
              child: Text(
                "Minimal",
                style: GoogleFonts.alegreyaSansSc(
                    fontSize: 60,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1500),
              top: ison ? 335 : 335,
              right: ison ? 55 : -200,
              child: Text(
                "Walls",
                style: GoogleFonts.alegreyaSansSc(
                    fontSize: 60,
                    color: Colors.teal[400],
                    fontWeight: FontWeight.w600),
              ),
            ),
            AnimatedPositioned(
              onEnd: () {},
              top: ison ? 359 : 359,
              left: ison ? 63 : -20,
              duration: const Duration(milliseconds: 1500),
              child: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.green[200],
              ),
            ),
            AnimatedPositioned(
              onEnd: () {},
              bottom: ison ? -120 : -500,
              left: ison ? 63 : -20,
              duration: const Duration(milliseconds: 1500),
              child: CircleAvatar(
                radius: 120,
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
            ),
            AnimatedPositioned(
              onEnd: () {},
              bottom: ison ? -120 : -329,
              left: ison ? -120 : -520,
              duration: const Duration(milliseconds: 1500),
              child: CircleAvatar(
                radius: 120,
                backgroundColor: Colors.green[200],
              ),
            ),
            AnimatedPositioned(
              onEnd: () {},
              bottom: ison ? -120 : -520,
              right: ison ? -120 : -520,
              duration: const Duration(milliseconds: 1500),
              child: CircleAvatar(
                radius: 120,
                backgroundColor: Colors.green[200],
              ),
            ),
            AnimatedPositioned(
              onEnd: () {},
              top: ison ? -120 : -520,
              right: ison ? 63 : -20,
              duration: const Duration(milliseconds: 1500),
              child: CircleAvatar(
                radius: 120,
                backgroundColor: Colors.green[200],
              ),
            ),
            AnimatedPositioned(
              onEnd: () {},
              top: ison ? -120 : -520,
              right: ison ? -120 : -520,
              duration: const Duration(milliseconds: 1500),
              child: CircleAvatar(
                radius: 120,
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
            ),
            AnimatedPositioned(
              onEnd: () {},
              top: ison ? -120 : -500,
              left: ison ? -120 : -500,
              duration: const Duration(milliseconds: 1500),
              child: CircleAvatar(
                radius: 120,
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
