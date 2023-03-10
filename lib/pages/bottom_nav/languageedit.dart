import 'package:flutter/material.dart';

class Language_edit extends StatelessWidget {
  const Language_edit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // The inital group value
  String _selectedlanguage = 'rus';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Редактировать профиль'),
        toolbarHeight: 100  ,
        backgroundColor: Colors.transparent, elevation: 0,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading:
        Container(height: 100.0,
          width: 100.0,
          margin: EdgeInsets.only(left: 10),
          child: FittedBox(
            child: FloatingActionButton( onPressed: () {
              Navigator.pop(context);
            },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.chevron_left, size: 30, color: Colors.black,),
              backgroundColor: Colors.white,),
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
                offset: Offset(0,3),
              )
            ],
          )
               ,child:
             ListTile(
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
              ),),
              Padding(padding: EdgeInsets.only(top: 20)),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 30,
                      offset: Offset(0,3),
                    )
                  ],
                ),
                child:
              ListTile(
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
          ),),

    );
  }
}
