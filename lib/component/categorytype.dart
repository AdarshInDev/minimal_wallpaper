import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryBox extends StatelessWidget {
  final String title;
  final String imgUrl;
  final void Function() onTap;
  const CategoryBox(
      {super.key,
      required this.title,
      required this.imgUrl,
      required this.onTap});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.only(bottom: 5.0),
          height: 170,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(imgUrl))),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black26,
                ),
              ),
              Center(
                child: Text(title,
                    style:
                        GoogleFonts.poppins(fontSize: 30, color: Colors.white)),
              )
            ],
          )),
    );
  }


 
}
