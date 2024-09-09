import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_wallpaper/pages/fullScreen.dart';
import 'package:minimal_wallpaper/service/database.dart';

class WallsCategory extends StatefulWidget {
  final String category;

  const WallsCategory({super.key, required this.category});

  @override
  State<WallsCategory> createState() => _WallsCategoryState();
}

class _WallsCategoryState extends State<WallsCategory> {
  Stream? categoryStream;
  onload() async {
    categoryStream = await DataBaseMethods().getwallStream(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    onload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(30),
            Container(
              decoration: BoxDecoration(
                  color: Colors.teal[300],
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Text(
                  widget.category,
                  style: GoogleFonts.alegreyaSansSc(
                      fontSize: 34,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Gap(30),
            Expanded(child: getAllwalls())
          ],
        ),
      ),
    );
  }

  Widget getAllwalls() {
    return StreamBuilder(
        stream: categoryStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    mainAxisSpacing: 6.0,
                    crossAxisSpacing: 6.0,
                  ),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreenImage(
                                      link: ds["Image"],
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            ds["Image"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  })
              : noStream();
        });
  }

  Widget noStream() {
    return Container(
      child: Center(
          child: Text(
        "Add Some Walls using Admin panel",
        style: GoogleFonts.alef(fontSize: 24, color: Colors.black),
      )),
    );
  }
}






// show dialog


// showDialog(
//                             context: context,
//                             builder: (context) {
//                               return Center(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20)),
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.95,
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.8,
//                                   child: Stack(
//                                     alignment: Alignment.center,
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10, vertical: 10),
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(20)),
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.95,
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.8,
//                                         child: ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                           child: Image.network(
//                                             ds["Image"],
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                       Positioned(
//                                         bottom: 40,
//                                         child: Material(
//                                           color: Colors.transparent,
//                                           child: Center(
//                                             child: Row(
//                                               children: [
//                                                 Mybutton(
//                                                     txt: "Cancel",
//                                                     onTap: () {
//                                                       Navigator.pop(context);
//                                                     },
//                                                     color: Colors.red[700],
//                                                     height: 50,
//                                                     width: 140),
//                                                 const Gap(10),
//                                                 Container(
//                                                   width: 60,
//                                                   height: 60,
//                                                   decoration:
//                                                       const BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                                   Radius
//                                                                       .circular(
//                                                                           40)),
//                                                           color: Color.fromRGBO(
//                                                               0, 121, 107, 1)),
//                                                   child: const Center(
//                                                     child: Icon(
//                                                       Icons.downloading_sharp,
//                                                       color: Colors.white,
//                                                       size: 45,
//                                                     ),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             });