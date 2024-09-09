// ignore: file_names
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:minimal_wallpaper/component/mybutton.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class FullScreenImage extends StatefulWidget {
  final String link;
  const FullScreenImage({super.key, required this.link});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Hero(
      tag: widget.link,
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.network(
              widget.link,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 40,
            left: MediaQuery.of(context).size.width * 0.1,
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  Mybutton(
                      txt: "Cancel",
                      onTap: () {
                        Navigator.pop(context);
                      },
                      color: Colors.red[700],
                      height: 50,
                      width: 140),
                  const Gap(30),
                  GestureDetector(
                    onTap: saveImage,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          color: Color.fromRGBO(0, 121, 107, 1)),
                      child: const Center(
                        child: Icon(
                          Icons.downloading_sharp,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  void saveImage() async {
    final bytes = (await get(Uri.parse(widget.link))).bodyBytes;
    final dir = await getTemporaryDirectory();
    final file =
        await File("${dir.path}/download_image.jpeg").writeAsBytes(bytes);
    log(file.path);
    await GallerySaver.saveImage(file.path, albumName: "Minimal Walls")
        .then((success) {
      print("suceess created!!");

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Successfully Downloaded in Gallery !! ")));
    });
  }
}



// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:minimal_wallpaper/component/mybutton.dart';
// import 'package:wallpaper/wallpaper.dart';

// class FullScreenImage extends StatefulWidget {
//   final String link;
//   const FullScreenImage({super.key, required this.link});

//   @override
//   _FullScreenImageState createState() => _FullScreenImageState();
// }

// class _FullScreenImageState extends State<FullScreenImage> {
//   String home = "Home Screen",
//       lock = "Lock Screen",
//       both = "Both Screen",
//       system = "System";

//   late Stream<String> progressString;
//   late String res;
//   bool downloading = false;

//   var result = "Waiting to set wallpaper";
//   bool _isDisable = true;

//   int nextImageID = 0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           downloading
//               ? imageDownloadDialog()
//               : SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                   child: Image.network(
//                     widget.link,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 140.0),
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                     backgroundColor: WidgetStatePropertyAll(
//                         Theme.of(context).colorScheme.primary)),
//                 onPressed: () async {
//                   return await downloadImage(context);
//                 },
//                 child: Text(
//                   "Download First",
//                   style: GoogleFonts.poppins(
//                       fontSize: 14, color: Colors.grey[800]),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 80.0, right: 20),
//             child: Align(
//               alignment: Alignment.bottomRight,
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                     backgroundColor: WidgetStatePropertyAll(Colors.blue[300])),
//                 onPressed: _isDisable
//                     ? null
//                     : () async {
//                         var width = MediaQuery.of(context).size.width;
//                         var height = MediaQuery.of(context).size.height;
//                         home = await Wallpaper.homeScreen(
//                             options: RequestSizeOptions.resizeFit,
//                             width: width,
//                             height: height);
//                         setState(() {
//                           downloading = false;
//                           home = home;
//                         });
//                         print("Task Done");
//                       },
//                 child: Text(
//                   home,
//                   style: GoogleFonts.poppins(
//                       fontSize: 14, color: Colors.grey[800]),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//               bottom: 20,
//             ),
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: Mybutton(
//                   txt: "Cancel",
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   color: Colors.red[700],
//                   height: 50,
//                   width: 140),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 80.0, left: 20),
//             child: Align(
//               alignment: Alignment.bottomLeft,
//               child: ElevatedButton(
//                 style: const ButtonStyle(
//                     backgroundColor: WidgetStatePropertyAll(Colors.white)),
//                 onPressed: _isDisable
//                     ? null
//                     : () async {
//                         await downloadImage(context);
//                         lock = await Wallpaper.lockScreen();
//                         setState(() {
//                           downloading = false;
//                           lock = lock;
//                         });
//                         print("Task Done");
//                       },
//                 child: Text(
//                   lock,
//                   style: GoogleFonts.poppins(
//                       fontSize: 14, color: Colors.grey[800]),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> downloadImage(BuildContext context) async {
//     progressString = Wallpaper.imageDownloadProgress(widget.link);
//     progressString.listen((data) {
//       setState(() {
//         res = data;
//         downloading = true;
//       });
//       print("DataReceived: $data");
//     }, onDone: () async {
//       setState(() {
//         downloading = false;
//         _isDisable = false;
//       });
//       print("Task Done");
//     }, onError: (error) {
//       setState(() {
//         downloading = false;
//         _isDisable = true;
//       });
//       print("Some Error");
//     });
//   }

//   Widget imageDownloadDialog() {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const CircularProgressIndicator(),
//             const SizedBox(height: 20.0),
//             Text(
//               "Downloading File : $res",
//               style: const TextStyle(color: Colors.black),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
