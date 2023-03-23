import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/generated/locale_keys.g.dart';
import 'package:kutpekz/pages/bottom_nav/favourites_page.dart';
import 'package:kutpekz/pages/bottom_nav/profile_page.dart';
import 'package:kutpekz/pages/search_bar.dart';
import 'package:provider/provider.dart';
import 'package:kutpekz/pages/history_page.dart';

// DID - PFP CHANGE
// DID - CUSTOM BOTTOM NAV BAR(HEIGHT, ICONS, CURVE)
// DID COLOR THEMES


// TODO - TIME PICKER -> BOOKING

// TODO - LOAD DATA WHILE APPLICATION LOADS
// TODO - BUG FIXING
// TODO if sms expired go to register page -> bug after which otp page doesn't show up

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
    SearchBar(),
    History(),
    FavouritesPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.getFavourites();
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
            //fontawesome antdesign
            BottomNavigationBarItem(icon: Icon(Iconsax.home, size: 24,), label: LocaleKeys.btm_nav_home.tr()),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.clock, size: 24,), label: LocaleKeys.btm_nav_history.tr()),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.heart, size: 24,), label: LocaleKeys.btm_nav_favourites.tr()),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.user, size: 24,), label: LocaleKeys.btm_nav_profile.tr()),
          ],
        ),
      ),
    );
  }
}
