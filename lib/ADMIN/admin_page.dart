import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minimal_wallpaper/component/mybutton.dart';
import 'package:minimal_wallpaper/service/database.dart';
import 'package:random_string/random_string.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool isuploading = false;
  final List<String> categories = [
    "Nature",
    "SkyScraper",
    "Tech",
    "WildLife",
    "AutoMobiles",
    "Anime"
  ];
  String? value;
  final ImagePicker picker = ImagePicker();
  File? selectedImage;
  Future getImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(30),
          Text(
            "Admin Page",
            style: GoogleFonts.alegreyaSansSc(
                fontSize: 34,
                fontWeight: FontWeight.w700,
                color: Colors.teal[100]),
          ),
          const Gap(20),
          Center(
              child: Material(
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(30),
                  child: GestureDetector(
                    onTap: getImage,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).colorScheme.primary,
                          border: Border.all(
                              width: 2,
                              color: const Color.fromARGB(255, 53, 82, 79))),
                      height: MediaQuery.of(context).size.height * 0.34,
                      width: MediaQuery.of(context).size.width * 0.67,
                      child: selectedImage == null
                          ? Icon(
                              Icons.camera_enhance,
                              size: 60,
                              color: Theme.of(context).colorScheme.secondary,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                            child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          // width: MediaQuery.of(context)
                                          //         .size
                                          //         .width *
                                          //     0.9,
                                          // height: MediaQuery.of(context)
                                          //         .size
                                          //         .height *
                                          //     0.7,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.file(
                                              selectedImage!,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ));
                                      });
                                },
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                  ))),
          const Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_upward_sharp,
                size: 30,
                color: selectedImage != null ? Colors.green[400] : Colors.black,
              ),
              const Gap(10),
              selectedImage != null
                  ? Text(
                      "Wall Selected",
                      style: GoogleFonts.alegreyaSansSc(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[400]),
                    )
                  : Text(
                      "Add Wallpaper",
                      style: GoogleFonts.alegreyaSansSc(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[200]),
                    ),
              const Gap(10),
              Icon(
                Icons.arrow_upward_sharp,
                size: 30,
                color: selectedImage != null ? Colors.green[400] : Colors.black,
              ),
            ],
          ),
          const Gap(15),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(10),
                dropdownColor: Theme.of(context).colorScheme.primary,
                items: categories
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: GoogleFonts.alegreyaSansSc(
                                color: Colors.white, fontSize: 20),
                          ),
                        ))
                    .toList(),
                onChanged: ((value) {
                  setState(() {
                    this.value = value;
                  });
                }),
                hint: Text(
                  "Select Category",
                  style: GoogleFonts.alegreyaSansSc(
                      color: Colors.white, fontSize: 20),
                ),
                value: value,
              ),
            ),
          ),
          const Gap(20),
          isuploading
              ? Mybutton(
                  color: Colors.teal[300],
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  txt: "Uploading . . . . ",
                  onTap: () {})
              : Mybutton(
                  color: Theme.of(context).colorScheme.secondary,
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  txt: "Add Wall",
                  onTap: uploadwall)
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    );
  }

  uploadwall() async {
    try {
      if (selectedImage != null && value!.isNotEmpty) {
        setState(() {
          isuploading = true;
        });
        String addId = randomAlphaNumeric(10);
        final ext = File(selectedImage!.path).path.split('.').last;
        Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
              "MinimalWalls/$addId.$ext",
            );

        final UploadTask task = firebaseStorageRef.putFile(
            selectedImage!, SettableMetadata(contentType: "image/$ext"));

        var downloadUrl = await (await task).ref.getDownloadURL();
        Map<String, dynamic> addItem = {"Image": downloadUrl, "id": addId};
        await DataBaseMethods().addWall(addItem, addId, value!).then((val) {
          setState(() {
            selectedImage = null;
            isuploading = false;
          });

          return Fluttertoast.showToast(
              msg:
                  "Minimal Wall added ✅ successfully in the $value category 😉",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color.fromARGB(255, 2, 160, 81),
              textColor: const Color.fromARGB(204, 255, 255, 255),
              fontSize: 16.0);
        });
      } else {
        if (value == "") {
          return Fluttertoast.showToast(
              msg: "Please Select Your Category First ❗",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color.fromRGBO(100, 181, 246, 1),
              textColor: Colors.black,
              fontSize: 16.0);
        } else if (selectedImage == null) {
          return Fluttertoast.showToast(
              msg: "Please Select a Minimal Wall First ❗",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color.fromRGBO(100, 181, 246, 1),
              textColor: Colors.black,
              fontSize: 16.0);
        }
      }
    } on Exception {
      // return Fluttertoast.showToast(
      //     msg: "Please Select Your Category First ❗",
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: const Color.fromRGBO(100, 181, 246, 1),
      //     textColor: Colors.black,
      //     fontSize: 16.0);
      // throw Exception(exception);
    } catch (error) {
      return Fluttertoast.showToast(
          msg: "Please Select Your Category First ❗",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromRGBO(100, 181, 246, 1),
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }
}
