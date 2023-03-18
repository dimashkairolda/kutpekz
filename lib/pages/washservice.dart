import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class washservice extends StatefulWidget {
  const washservice({Key? key}) : super(key: key);

  @override
  State<washservice> createState() => _washserviceState();
}

class _washserviceState extends State<washservice> {
  final urlImages = ['https://images.unsplash.com/photo-1678765247633-deb85f9d980d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1964&q=80',
                      'https://images.unsplash.com/photo-1678769045823-b3a11ed82835?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1172&q=80'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Подробно'),
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
            },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.chevron_left, size: 30, color: Colors.black,),
              backgroundColor: Colors.white,),
          ),
        ),
        actions: [
          Container(height: 50.0,
            width: 50.0,
            margin: EdgeInsets.only(right: 10),

            child: FittedBox(
              child: FloatingActionButton( onPressed: () {
              },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.favorite_border, size: 30, color: Colors.black,),
                backgroundColor: Colors.white,),
            ),
          ),
        ],

      ),
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              CarouselSlider.builder(itemCount: urlImages.length,
                  itemBuilder: (context, index, realIndex){
                    final urlImage = urlImages[index];

                    return buildImage(urlImage, index);
                  },
                  options: CarouselOptions(height: 200),),

              Padding(padding: EdgeInsets.fromLTRB(25, 55, 25, 29),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Avtomoika Montana', style: TextStyle(fontFamily: 'San Francisco', fontWeight: FontWeight.w700, fontSize: 24),),
                      Text('ул.Пятницкого, 86/2, Алматы', style: TextStyle(fontFamily: 'San Francisco', fontWeight: FontWeight.w400, fontSize: 16),),
                    ],
                  ),
                ],
              ),),
            Divider(color: Colors.black,height: 20,
              thickness: 3,
            indent: 25,
            endIndent: 25,),
            Padding(padding: EdgeInsets.only(top: 25)),
            Text('О нас', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, fontFamily: 'San Francisco'),),
            Padding(padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
            child: Row(

              children: [
                Column(

               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Text('Время работы', style: TextStyle(fontFamily: 'San Francisco',fontWeight: FontWeight.w700, fontSize: 18),),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  Row(
                    children: [
                      Text('Понедельник - пятница', style: TextStyle(fontSize: 14, fontFamily: 'San Francisco', fontWeight: FontWeight.w400),),
                      Padding(padding: EdgeInsets.only(right: 16)),
                      Text(':'),
                      Padding(padding: EdgeInsets.only(right: 9)),
                      Text('10:00 - 24:00', style: TextStyle(fontFamily: 'San Francisco', fontWeight: FontWeight.w700,fontSize: 14),)
                    ],
                  ),
                 Padding(padding: EdgeInsets.only(top: 10)),
                 Row(
                   children: [
                     Text('Суббота - воскресенье', style: TextStyle(fontSize: 14, fontFamily: 'San Francisco', fontWeight: FontWeight.w400),),
                     Padding(padding: EdgeInsets.only(right: 16)),
                     Text(':'),
                     Padding(padding: EdgeInsets.only(right: 9)),
                     Text('10:00 - 16:00', style: TextStyle(fontFamily: 'San Francisco', fontWeight: FontWeight.w700,fontSize: 14),)
                   ],
                 ),
                 Padding(padding: EdgeInsets.only(top: 23)),
                 Text('Контакты', style: TextStyle(fontFamily: 'San Francisco',fontWeight: FontWeight.w700, fontSize: 18),),
                 Padding(padding: EdgeInsets.only(top: 10)),
                 Text('8 777 777 77 77', style: TextStyle(fontFamily: 'San Francisco',fontWeight: FontWeight.w700, fontSize: 14),),
                 Padding(padding: EdgeInsets.only(top: 23)),
                 Text('Наш адрес', style: TextStyle(fontFamily: 'San Francisco',fontWeight: FontWeight.w700, fontSize: 18),),
                 Padding(padding: EdgeInsets.only(top: 10)),
                 Text('ул.Пятницкого, 86/2, Алматы', style: TextStyle(fontFamily: 'San Francisco', fontWeight: FontWeight.w400, fontSize: 16),),
                 Padding(padding: EdgeInsets.only(top: 23)),

               ],
              ),

              ],

            ),
            ),

            Divider(color: Colors.black,height: 20,
              thickness: 3,
              indent: 25,
              endIndent: 25,),
            Padding(padding: EdgeInsets.only(top: 35)),
            Text('Сервисы', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, fontFamily: 'San Francisco'),),
            Padding(padding: EdgeInsets.only(top: 24)),
            Container(
    width: 340,
    height: 50,
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
      child: Padding( padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        children: [
          Row(children: [
            Text('Мойка машин', style: TextStyle(fontFamily: 'San Francisco', fontSize: 16,fontWeight: FontWeight.w700,), textAlign: TextAlign.center,),
            Spacer(),
            Text('2000₸', style: TextStyle(fontFamily: 'San Francisco', fontSize: 16,fontWeight: FontWeight.w700,), textAlign: TextAlign.center,),


          ],)
        ],
      ),
      ),

      ),
            Padding(padding: EdgeInsets.only(top: 24)),
            Container(
              width: 340,
              height: 50,
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
              child: Padding( padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  children: [
                    Row(children: [
                      Text('Химчистка автомобилей', style: TextStyle(fontFamily: 'San Francisco', fontSize: 16,fontWeight: FontWeight.w700,), textAlign: TextAlign.center,),
                      Spacer(),
                      Text('2000₸', style: TextStyle(fontFamily: 'San Francisco', fontSize: 16,fontWeight: FontWeight.w700,), textAlign: TextAlign.center,),


                    ],)
                  ],
                ),
              ),

            ),
            Padding(padding: EdgeInsets.only(top: 40)),
            SizedBox(
                width: 334,
                height: 35,
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
                        "Забронировать",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      onPressed: ()  {
                        Navigator.pushNamed(context, '/booking');

                      },
                    ),
                  ),
                )),
            Padding(padding: EdgeInsets.only(bottom: 40))




    ],),),);
  }

  Widget buildImage(String urlImage, int index)=> Container(
    margin: EdgeInsets.symmetric(horizontal: 12),
    color: Colors.grey,
    child: Image.network(urlImage,fit: BoxFit.cover,),
  );
}
