import 'package:flutter/material.dart';

class Language_Edit extends StatelessWidget {
  const Language_Edit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'Редактировать профиль',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 25,
            ),

            SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 50,
            ),


            SizedBox(
              height: 10,
            ),


            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    Padding(padding: EdgeInsets.only(right: 30)),

                    Text('Имя',)],),
                Padding(padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Имя Фамилия',
                      border: OutlineInputBorder(),
                    )
                    ,),

                ),
                Padding(padding: EdgeInsets.only(bottom: 50)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    Padding(padding: EdgeInsets.only(right: 30)),

                    Text('Номер телефона',)],),
                Padding(padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: '+7 777 777 77 77',
                      border: OutlineInputBorder(),
                    )
                    ,),

                ),
              ],
            ),

            SizedBox(
              height: 60,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color.fromRGBO(145, 122, 253, 1),
                          Color.fromRGBO(98, 78, 234, 1)
                        ]),
                  ),
                  child: Material(
                    elevation: 5,
                    color: Colors.transparent,
                    child: MaterialButton(
                      child: Text(
                        "Сохранить",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                            color: Colors.white),
                      ),
                      onPressed: (){

                      },
                    ),
                  ),
                ))
          ],
        ),
      ),

      floatingActionButton: Stack(
        children: [
          Positioned(
            top: 65,
            left: 40,
            child: Container(
              width: 40,
              height: 40,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.chevron_left,size: 30,),
                backgroundColor: Colors.white,
              ),
            ),),
        ],
      ),);
  }
}
