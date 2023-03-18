import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/pages/bottom_nav/languageedit.dart';
import 'package:kutpekz/pages/bottom_nav/profileedit.dart';
import 'package:kutpekz/pages/loading_page.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Профиль',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              child: CircleAvatar(
                radius: 47.5,
                backgroundImage: ap.pfp,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Здравстуйте, ${ap.userModel.name}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 50,
            ),
            Divider(
              color: Colors.grey.shade300,
              endIndent: 30,
              indent: 30,
              thickness: 1.25,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 30),
                  leading: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Редактировать Профиль',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEdit()));
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 30),
                  leading: const Icon(
                    Icons.credit_card_rounded,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Оплата',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 30),
                  leading: const Icon(
                    Icons.language,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Язык',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageEdit()));
                  },
                ),
              ],
            ),
            Divider(
              color: Colors.grey.shade300,
              endIndent: 30,
              indent: 30,
              thickness: 1.25,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: const LinearGradient(
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
                    child: const Text(
                      "Выйти",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Colors.white),
                    ),
                    onPressed: () async {
                      // Exit form profile and app
                      showDialog(context: context, builder: (ctx) => CupertinoAlertDialog(
                        title: const Text("Вы действительно хотите выйти?"),
                        actions: [
                          CupertinoDialogAction(child: TextButton(
                            child: const Text("Да"),
                            onPressed: () { ap.userSignOut().then((value) => Navigator.of(context)
                              .pushAndRemoveUntil( MaterialPageRoute(
                                  builder: (context) => const LoadingPage()), ((route) => false))); },
                            ),
                          ),
                          CupertinoDialogAction(child: TextButton(
                            child: const Text("Нет"),
                            onPressed: (){Navigator.of(ctx).pop();},
                            ),
                          ),
                        ],
                      ));

                    },
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
