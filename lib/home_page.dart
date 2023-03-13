import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/pages/bottom_nav/profile_page.dart';
import 'package:kutpekz/pages/map_page.dart';
import 'package:kutpekz/pages/washservice.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:kutpekz/pages/history_page.dart';

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
      print("index..." + index.toString());
    });
  }

  final List  _pages = [
    MapPage(),
    washservice(),
    History(),
    Text("Избранное"),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
        body: Stack(
          children: [
            Center(child:_pages[_selectedTabIndex]),
          ],
        ),
        bottomNavigationBar: bottomNavigationBar,
    );


  }

  Widget get bottomNavigationBar {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedTabIndex,
            onTap: _changeIndex,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedItemColor: Color(0xff6246EA),
            unselectedItemColor: Colors.grey[500],
            showUnselectedLabels: true,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Главная'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Уведомления'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'История'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Избранное'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Профиль'
              ),
            ],
          ),
        ));
  }

  Widget buildFloatingSearchBar() {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    FloatingSearchBarController controller = FloatingSearchBarController();
    return FloatingSearchBar(
      elevation: 10,
      hint: 'Поиск',
      clearQueryOnClose: false,
      margins: EdgeInsets.only(top: 50),
      borderRadius: BorderRadius.circular(32),
      automaticallyImplyBackButton: true,
      controller: controller,
      leadingActions: const [
        Icon(
          Icons.search
        )
      ],
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Search here!!

      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.icon(
          icon: Icons.clear, onTap: () {
            controller.clear();
        },
          showIfClosed: false,
          showIfOpened: true,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

}
