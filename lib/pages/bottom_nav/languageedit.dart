import 'package:flutter/material.dart';

class LanguageEdit extends StatefulWidget {
  const LanguageEdit({Key? key}) : super(key: key);

  @override
  State<LanguageEdit> createState() => _LanguageEditState();
}

// TODO - ADD BUTTON & CLICK LISTTILE

class _LanguageEditState extends State<LanguageEdit> {
  // The inital group value
  String _selectedlanguage = 'rus';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Изменить язык'),
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
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
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.chevron_left,
                size: 30,
                color: Colors.black,
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 30,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: ListTile(
                trailing: Radio<String>(
                  value: 'kaz',
                  groupValue: _selectedlanguage,
                  onChanged: (value) {
                    setState(() {
                      _selectedlanguage = value!;
                    });
                  },
                ),
                title: const Text('Қазақша'),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 30,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: ListTile(
                trailing: Radio<String>(
                  value: 'rus',
                  groupValue: _selectedlanguage,
                  onChanged: (value) {
                    setState(() {
                      _selectedlanguage = value!;
                    });
                  },
                ),
                title: const Text('Русский'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
