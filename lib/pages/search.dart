import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:minimal_wallpaper/models/photo_model.dart';
import 'package:minimal_wallpaper/pages/fullScreen.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isSearch = false;
  List<PhotoModel> photos = [];
  String number = "";
//getting connectioon to the pexels api
  getSearchWallpaper(String searchQuery) async {
    setState(() {
      isSearch = false;
    });
    number = "";
    photos.clear();
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$searchQuery&per_page=40"),
        headers: {
          "authorization":
              "gn5yfek5lXIsG9l9rCfBNfeMaFkjJVm8A6n3HnlpPPW16vjVskbJDpSP"
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        PhotoModel photomodel = PhotoModel();
        photomodel = PhotoModel.fromMap(element);
        photos.add(photomodel);
      });
      print(jsonData["photos"].toString());
      print("Necche dekho model");
      print(photos.toString());
      setState(() {
        photos = photos;
        searchQuery = searchQuery.toUpperCase();
        number = "Your 30 minimal $searchQuery Walls are here";
      });
    });
  }

  final TextEditingController searchctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  // color: Colors.white,
                  height: 50,
                  width: 50,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 20,
                        left: 10,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green[600],
                              borderRadius: BorderRadius.circular(20)),
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green[300],
                              borderRadius: BorderRadius.circular(20)),
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Text("Search Minimals",
                    style: GoogleFonts.alegreyaSansSc(
                        fontSize: 25,
                        color: Colors.teal[100],
                        fontWeight: FontWeight.w500)),
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
            Center(
              child: TextField(
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary),
                cursorColor: Colors.teal[900],
                onTapOutside: (event) {
                  searchctrl.clear();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                controller: searchctrl,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    focusColor: Theme.of(context).colorScheme.primary,
                    suffixIcon: IconButton(
                        onPressed: () {
                          getSearchWallpaper(searchctrl.text);
                          setState(() {
                            isSearch = true;
                          });
                          print(photos.toString());
                        },
                        icon: Icon(
                          Icons.search,
                          size: 25,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    hintText: "Search",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(158, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary))),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            (photos.isNotEmpty && isSearch)
                ? Text(
                    number,
                    style: GoogleFonts.alegreyaSansSc(
                        fontSize: 16,
                        color: Colors.teal[100],
                        fontWeight: FontWeight.w500),
                  )
                : (isSearch)
                    ? Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Cant Find What you Want",
                                style: GoogleFonts.alegreyaSansSc(
                                    fontSize: 20,
                                    color: Colors.blue[200],
                                    fontWeight: FontWeight.w500),
                              ),
                              Lottie.asset(
                                  height: 180,
                                  "lib/assets/lottie_animations/error_animation.json")
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
            const SizedBox(
              height: 20,
            ),
            isSearch
                ? Expanded(child: wallpaper(photos, context))
                : Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Lottie.asset(
                              height: 180,
                              "lib/assets/lottie_animations/loading_animation.json"),
                          Text(
                            "Search Your Minimal Walls",
                            style: GoogleFonts.alegreyaSansSc(
                                color: Colors.teal[100],
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            " Now",
                            style: GoogleFonts.alegreyaSansSc(
                                color: Colors.teal[100],
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget wallpaper(List<PhotoModel> listPhotos, BuildContext context) {
    print("${listPhotos.length} bye bye");
   
    return Container(
      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 6.0,
          children: listPhotos.map((PhotoModel photosModel) {
            print(photosModel.url);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FullScreenImage(
                              link: photosModel.src!.portrait!,
                            )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GridTile(
                  footer: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Center(
                        child: Text(
                      "@ ${photosModel.photographer!}",
                      style: GoogleFonts.adventPro(
                          fontSize: 22, color: Colors.white),
                    )),
                  ),
                  child: Hero(
                      tag: photosModel.src!.portrait!,
                      child: Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(photosModel.src!.portrait!))),
                ),
              ),
            );
          }).toList()),
    );
  }
}
