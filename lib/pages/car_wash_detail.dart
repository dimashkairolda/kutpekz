import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kutpekz/models/car_washes_model.dart';
import 'package:kutpekz/pages/booking.dart';
import 'package:provider/provider.dart';

import '../auth_provider.dart';

class CarWashDetail extends StatefulWidget {
  const CarWashDetail({Key? key, required this.carWash}) : super(key: key);
  final CarWashes carWash;

  @override
  State<CarWashDetail> createState() => _CarWashDetailState();
}

Icon getIcon(bool isFavourite) {
  return isFavourite
      ? const Icon(Icons.favorite)
      : const Icon(Icons.favorite_border);
}

class _CarWashDetailState extends State<CarWashDetail> {
  final urlImages = [
    'https://images.unsplash.com/photo-1678765247633-deb85f9d980d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1964&q=80',
    'https://images.unsplash.com/photo-1678769045823-b3a11ed82835?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1172&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    int id = int.parse(widget.carWash.uid);
    bool isFavourite = ap.favourites[id];
    Icon icon = isFavourite
        ? const Icon(Iconsax.heart5, )
        : const Icon(Iconsax.heart,);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Подробно'),
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: Container(
          height: 100.0,
          width: 100.0,
          margin: const EdgeInsets.only(left: 10),
          child: FittedBox(
            child: FloatingActionButton(
              heroTag: UniqueKey(),
              onPressed: () {
                Navigator.pop(context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Iconsax.arrow_left_2,
                size: 30,
              ),
            ),
          ),
        ),
        actions: [
          Container(
            height: 50.0,
            width: 50.0,
            margin: const EdgeInsets.only(right: 10),
            child: FittedBox(
              child: FloatingActionButton(
                heroTag: UniqueKey(),
                onPressed: () {
                  setState(() {
                    isFavourite = !isFavourite;
                    ap.favourites[id] = isFavourite;
                    ap.updateFavourites(context);
                    icon = isFavourite
                        ? const Icon(Icons.favorite,)
                        : const Icon(Icons.favorite_border,);
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: icon,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              itemCount: urlImages.length,
              itemBuilder: (context, index, realIndex) {
                final urlImage = urlImages[index];
                return buildImage(urlImage, index);
              },
              options: CarouselOptions(height: 200),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 55, 25, 29),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.carWash.name,
                        style: const TextStyle(
                          fontFamily: 'San Francisco',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        widget.carWash.address,
                        style: const TextStyle(
                          fontFamily: 'San Francisco',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 3,
              indent: 25,
              endIndent: 25,
            ),
            const Padding(padding: EdgeInsets.only(top: 25)),
            const Text(
              'О нас',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  fontFamily: 'San Francisco'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Время работы',
                        style: TextStyle(
                            fontFamily: 'San Francisco',
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                      Row(
                        children: [
                          const Text(
                            'Понедельник - пятница',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'San Francisco',
                                fontWeight: FontWeight.w400),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 16)),
                          const Text(':'),
                          const Padding(padding: EdgeInsets.only(right: 9)),
                          Text(
                            widget.carWash.weekDayHours,
                            style: const TextStyle(
                                fontFamily: 'San Francisco',
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          )
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Row(
                        children: [
                          const Text(
                            'Суббота - воскресенье',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'San Francisco',
                                fontWeight: FontWeight.w400),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 16)),
                          const Text(':'),
                          const Padding(padding: EdgeInsets.only(right: 9)),
                          Text(
                            widget.carWash.weekEndHours,
                            style: const TextStyle(
                                fontFamily: 'San Francisco',
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          )
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 23)),
                      const Text(
                        'Контакты',
                        style: TextStyle(
                            fontFamily: 'San Francisco',
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        widget.carWash.phoneNumber,
                        style: const TextStyle(
                            fontFamily: 'San Francisco',
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 23)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 3,
              indent: 25,
              endIndent: 25,
            ),
            const Padding(padding: EdgeInsets.only(top: 35)),
            const Text(
              'Сервисы',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  fontFamily: 'San Francisco'),
            ),
            const Padding(padding: EdgeInsets.only(top: 24)),
            Container(
              width: 340,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Мойка машин',
                          style: TextStyle(
                            fontFamily: 'San Francisco',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                        Text(
                          '2000₸',
                          style: TextStyle(
                            fontFamily: 'San Francisco',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 24)),
            Container(
              width: 340,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Химчистка автомобилей',
                          style: TextStyle(
                            fontFamily: 'San Francisco',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                        Text(
                          '2000₸',
                          style: TextStyle(
                            fontFamily: 'San Francisco',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 40)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: CupertinoButton(
                color: Color.fromRGBO(98, 78, 234, 1),
                borderRadius: BorderRadius.circular(10),
                child: const Text(
                  "Забронировать",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    ap.setBookedCarWashName(widget.carWash.name);
                    ap.setBookedCarWashAddress(widget.carWash.address);
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Booking(carWash: widget.carWash)));
                },
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 40))
          ],
        ),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );
}
