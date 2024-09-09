import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_wallpaper/ADMIN/admin_page.dart';
import 'package:minimal_wallpaper/component/mybutton.dart';
import 'package:minimal_wallpaper/component/textfield.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  bool onlogin = false;
  bool isobsecure = true;
  TextEditingController emailctrl = TextEditingController();
  TextEditingController passctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 110.0))),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.12,
              right: MediaQuery.of(context).size.width * 0.11,
              child: Text(
                "Hello There\nAdmin ,",
                style: GoogleFonts.afacad(
                    fontSize: 34,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              left: MediaQuery.of(context).size.width / 10,
              child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.245,
                    height: MediaQuery.of(context).size.height / 2.4,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18.0, top: 28),
                      child: loginWidget(),
                    ),
                  )),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.04,
              left: MediaQuery.of(context).size.width * 0.01,
              child: Lottie.asset(
                  backgroundLoading: true,
                  height: MediaQuery.of(context).size.height * 0.24,
                  "lib/assets/lottie_animations/login_page_hi.json"),
            ),
          ],
        ));
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admins").get().then((snapshot) {
      for (var result in snapshot.docs) {
        if (result.data()['id'].toString() !=
            emailctrl.text.toString().trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
              "Your username is not correct",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            backgroundColor: Colors.red[400],
          ));
        }
        if (result.data()['password'].toString() !=
            passctrl.text.toString().trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
              "Your password is not correct",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            backgroundColor: Colors.red[400],
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Center(
              child: Text(
                "Welcome Admin ",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            backgroundColor: Colors.green[400],
            showCloseIcon: true,
            closeIconColor: Colors.white,
          ));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminPage()),
          );
        }
      }
    });
  }

  Widget loginWidget() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              onlogin = true;
              print(onlogin);
            });
          },
          child: Container(
            child: TField(
              title: "Username",
              icon: Icons.person,
              ctrl: emailctrl,
              func: () {},
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        TField(
          title: "Password",
          icon: isobsecure ? Icons.visibility_off : Icons.visibility,
          ctrl: passctrl,
          enabled: isobsecure,
          func: () {
            setState(() {
              isobsecure = !isobsecure;
            });
          },
        ),
        const SizedBox(
          height: 40,
        ),
        Mybutton(
          height: 45,
          width: MediaQuery.of(context).size.width,
          txt: 'Login',
          onTap: loginAdmin,
          color: Colors.teal,
        )
      ],
    );
  }
}


// onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => const BottomNav()),
//                   (route) => false);
//             },
