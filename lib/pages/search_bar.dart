import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

Widget buildFloatingSearchBar(BuildContext context) {
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
          if(controller.query.isNotEmpty){
            controller.clear();
          }
          else{
            controller.close();
          }
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