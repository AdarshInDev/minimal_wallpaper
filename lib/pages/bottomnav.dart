import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:minimal_wallpaper/ADMIN/admin_login.dart';
import 'package:minimal_wallpaper/pages/categories.dart';
import 'package:minimal_wallpaper/pages/home.dart';
import 'package:minimal_wallpaper/pages/search.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabindex = 0;
  late List<Widget> pages;
  late Home home;
  late Categories categories;
  late Search search;
  late AdminLogin admin;
  late Widget currentPage;
  @override
  void initState() {
    // TODO: implement initState
    home = const Home();
    categories = const Categories();
    search = const Search();
    currentPage = const Home();
    admin = const AdminLogin();
    pages = [home, search, categories, admin];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          backgroundColor: currentTabindex == 3
              ? Colors.black
              : Theme.of(context).colorScheme.inversePrimary,
          buttonBackgroundColor: const Color.fromARGB(255, 47, 61, 68),
          color: Theme.of(context).colorScheme.primary,
          animationDuration: const Duration(milliseconds: 500),
          onTap: (index) {
            setState(() {
              currentTabindex = index;
            });
          },
          items: const [
            Icon(
              Icons.home_filled,
              color: Colors.white,
              size: 25,
            ),
            Icon(
              Icons.search,
              color: Colors.white,
              size: 25,
            ),
            Icon(
              Icons.category_rounded,
              color: Colors.white,
              size: 25,
            ),
            Icon(
              Icons.person,
              color: Colors.white,
              size: 25,
            )
          ]),
      body: pages[currentTabindex],
    );
  }
}
