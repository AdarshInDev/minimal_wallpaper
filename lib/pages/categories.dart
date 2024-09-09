import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_wallpaper/component/categorytype.dart';
import 'package:minimal_wallpaper/pages/wallsList.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    // color: Colors.white,
                    height: 50,
                    width: 40,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 20,
                            left: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green[300],
                                  borderRadius: BorderRadius.circular(20)),
                              width: 30,
                              height: 30,
                            )),
                        Positioned(
                          top: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green[600],
                              // borderRadius: BorderRadius.circular(20)
                            ),
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Text("Minimal Categories",
                      style: GoogleFonts.alegreyaSansSc(
                          fontSize: 25,
                          color: Colors.teal[100],
                          fontWeight: FontWeight.w600)),
                ],
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
              CategoryBox(
                title: "WildLife",
                imgUrl:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTS3aRPfPJYsBCHkFQ4vDlwgdyueIxYyPAkjQ&s",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const WallsCategory(
                                category: 'WildLife',
                              )));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CategoryBox(
                title: "Nature",
                imgUrl:
                    "https://m.media-amazon.com/images/I/7125AinG8EL._SL500_.jpg",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const WallsCategory(
                                category: 'Nature',
                              )));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CategoryBox(
                title: "SkyScrapers",
                imgUrl:
                    "https://images.pexels.com/photos/169647/pexels-photo-169647.jpeg?cs=srgb&dl=pexels-peng-liu-45946-169647.jpg&fm=jpg",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const WallsCategory(
                                category: 'SkyScraper',
                              )));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CategoryBox(
                title: "AutoMobiles",
                imgUrl:
                    "https://blogger.googleusercontent.com/img/a/AVvXsEjTTNx9vpKHfSvgwa1pQS3XSKNpB23PLyP-MYd5kMRaBOqMsLhYvHmKYxeK_3idKi-2jPOmGFRbEJBWUl48DS2pUvlSJIMb1GbNBpr_AbjLH_gtqK6wWhlQqRWvR4pjCOfeKf00nPph-pGlj5d1abGHgwXKsdULC9U3s77RNgc9sJfYKcexeQmkTYx_GOg=s1600-rw",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const WallsCategory(
                                category: 'AutoMobiles',
                              )));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CategoryBox(
                title: "Tech",
                imgUrl:
                    "https://media.istockphoto.com/id/1961324209/photo/a-concept-where-various-creative-thoughts-are-formed-within-a-light-bulb-3d-rendering.webp?b=1&s=612x612&w=0&k=20&c=PhQyAW5LaWqdVm7qTg9c4pNH8puAhGSPnvyXdQE99qE=",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const WallsCategory(
                                category: 'Tech',
                              )));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CategoryBox(
                title: "Anime",
                imgUrl:
                    "https://wallpapercave.com/wp/wp5170619.jpg",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const WallsCategory(
                                category: 'Anime',
                              )));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
