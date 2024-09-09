import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_wallpaper/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static bool islight = false;
  List<String> wallpaperImage = [
    "https://wallpapers.com/images/featured/nature-phone-gru786336nspczhn.jpg",
    "https://wallpaper.forfun.com/fetch/44/44b208e04a532e7077071d32baebf666.jpeg",
    "https://w0.peakpx.com/wallpaper/32/508/HD-wallpaper-river-between-trees.jpg"
  ];
  int activeindex = 0;
  int value = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        // color: Colors.white,
                        height: 60,
                        width: 60,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 20,
                              left: 10,
                              child: Container(
                                width: 30,
                                height: 30,
                                color: Colors.green[600],
                              ),
                            ),
                            Positioned(
                              top: 10,
                              child: Container(
                                width: 30,
                                height: 30,
                                color: Colors.green[300],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Text(
                        "Minimal Walls",
                        style: GoogleFonts.alegreyaSansSc(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(200, 255, 255, 255)),
                      ),
                      const Gap(8),
                      // AnimatedToggleSwitch<int>.rolling(
                      //   height: 50,
                      //   borderWidth: 3,
                      //   active: islight,
                      //   iconList: const [
                      //     Icon(Icons.light_mode_outlined),
                      //     Icon(Icons.dark_mode_outlined),
                      //   ],
                      //   current: islight ? 0 : 1,
                      //   values: const [
                      //     0,
                      //     1,
                      //   ],
                      //   onChanged: (i) {
                      //     Provider.of<ThemeProvider>(context, listen: false)
                      //         .toggleTheme();
                      //     setState(() {
                      //       islight = !islight;
                      //       i = islight ? 0 : 1;
                      //     });
                      //   },
                      //   // iconBuilder: iconBuilder,
                      //   // iconList: [...], you can use iconBuilder, customIconBuilder or iconList
                      //   style: ToggleStyle(
                      //       indicatorColor: Theme.of(context)
                      //           .colorScheme
                      //           .inversePrimary), // optional style settings
                      //   // ... // many more parameters available
                      // ).vertical(),
                      CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          radius: 24,
                          child: IconButton(
                            onPressed: () {
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .toggleTheme();
                              setState(() {
                                islight = !islight;
                              });
                            },
                            icon: islight
                                ? Icon(Icons.dark_mode_outlined,
                                    color: Colors.teal[200])
                                : const Icon(
                                    Icons.light_mode_outlined,
                                    color: Colors.amber,
                                  ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 3,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 30,
                ),
                CarouselSlider.builder(
                    options: CarouselOptions(
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        padEnds: true,
                        autoPlay: true,
                        height: MediaQuery.of(context).size.height * 0.6,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeindex = index;
                          });
                        }),
                    itemCount: wallpaperImage.length,
                    itemBuilder: (context, index, realIndex) {
                      final res = wallpaperImage[index];
                      return buildImage(res, index);
                    }),
                const SizedBox(
                  height: 20,
                ),
                buildIndicator()
              ],
            ),
          )),
    );
  }

  Widget buildImage(String urlImage, int index) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.7,
      width: MediaQuery.of(context).size.width / 1.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image:
              DecorationImage(fit: BoxFit.fill, image: NetworkImage(urlImage))),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
        onDotClicked: (index) {
          activeindex = index;
        },
        activeIndex: activeindex,
        count: 3,
        effect: JumpingDotEffect(
          spacing: 20,
          dotColor: Theme.of(context).colorScheme.primary,
          activeDotColor: const Color.fromARGB(255, 54, 152, 233),
          dotHeight: 10,
          dotWidth: 10,
        ));
  }
}
