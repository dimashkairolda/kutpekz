import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kutpekz/generated/locale_keys.g.dart';
import 'package:kutpekz/pages/bottom_nav/favourites_page.dart';
import 'package:kutpekz/pages/bottom_nav/profile/profile_page.dart';
import 'package:kutpekz/pages/bottom_nav/map/search_bar.dart';
import 'package:kutpekz/pages/bottom_nav/history/history_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  final List<Widget> _pages = [
    const SearchBar(),
    const History(),
    const FavouritesPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _pages[_selectedTabIndex],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: bottomNavigationBar,
            ),
          )
        ],
      ),
      // bottomNavigationBar: ,
    );
  }

  Widget get bottomNavigationBar {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedTabIndex,
          onTap: _changeIndex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: const Color(0xff6246EA),
          unselectedItemColor: Theme.of(context).primaryColor,
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: const Icon(Iconsax.home, size: 24,), label: LocaleKeys.btm_nav_home.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Iconsax.clock, size: 24,), label: LocaleKeys.btm_nav_history.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Iconsax.heart, size: 24,), label: LocaleKeys.btm_nav_favourites.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Iconsax.user, size: 24,), label: LocaleKeys.btm_nav_profile.tr()),
          ],
        ),
      ),
    );
  }
}
