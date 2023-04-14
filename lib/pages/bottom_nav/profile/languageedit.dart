import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LanguageEdit extends StatefulWidget {
  const LanguageEdit({Key? key}) : super(key: key);

  @override
  State<LanguageEdit> createState() => _LanguageEditState();
}

// TODO - ADD BUTTON & CLICK LISTTILE

class _LanguageEditState extends State<LanguageEdit> {
  // The inital group value
  String _selectedlanguage = 'ru';

  @override
  Widget build(BuildContext context) {
    _selectedlanguage = context.locale.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Изменить язык'),
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        leading: Container(
          height: 100.0,
          width: 100.0,
          margin: const EdgeInsets.only(left: 10),
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              heroTag: UniqueKey(),
              child: const Icon(
                Iconsax.arrow_left_2,
                size: 30,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: CheckboxListTile(
                // activeColor: Colors.white,
                checkColor: Colors.grey.shade900,
                checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: Theme.of(context).scaffoldBackgroundColor)),
                value: _selectedlanguage == 'kk',
                onChanged: (value) async {
                  _selectedlanguage = 'kk';
                  await context.setLocale(Locale('kk'));
                  setState(() {

                  });},
                title: Text('Қазақша', style: TextStyle(color: Colors.grey.shade900),),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: CheckboxListTile(
                // activeColor: Colors.white,
                checkColor: Colors.grey.shade900,
                checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: Theme.of(context).scaffoldBackgroundColor)),
                value: _selectedlanguage == 'ru',
                onChanged: (value) async {
                  _selectedlanguage = 'ru';
                  await context.setLocale(Locale('ru'));
                  setState(() {

                  });},
                title: Text('Русский', style: TextStyle(color: Colors.grey.shade900),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
