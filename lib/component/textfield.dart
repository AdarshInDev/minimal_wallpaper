import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TField extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final bool? enabled;
  void Function()? func;
  final TextEditingController ctrl;
  void Function()? onTap;
  TField(
      {super.key,
      this.onTap,
      required this.title,
      required this.icon,
      required this.ctrl,
      required this.func,
      this.enabled});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {},
      style: GoogleFonts.poppins(
          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      cursorColor: Colors.teal[200],
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      obscureText: enabled ?? false,
      controller: ctrl,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          focusColor: Theme.of(context).colorScheme.primary,
          suffixIcon: GestureDetector(
            onTap: func,
            child: Icon(
              icon,
              size: 25,
              color: Colors.white,
            ),
          ),
          hintText: title,
          hintStyle: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 81, 106, 117),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary))),
    );
  }
}
