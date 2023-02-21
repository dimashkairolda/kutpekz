import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
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
            SizedBox(
              height: 40,
            ),
            Text(
              'Профиль',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: CircleAvatar(
                radius: 47.5,
                backgroundImage: NetworkImage(ap.userModel.profilePicture),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Здравстуйте, ${ap.userModel.name}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 60,
            ),
            Divider(
              color: Colors.grey,
              endIndent: 30,
              indent: 30,
              thickness: 1.25,
            ),
            SizedBox(
              height: 100,
            ),
            Divider(
              color: Colors.grey,
              endIndent: 30,
              indent: 30,
              thickness: 1.25,
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
                        "Выйти",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                            color: Colors.white),
                      ),
                      onPressed: () async {
                        // Exit form profile and app
                        ap.userSignOut().then((value) => Navigator.of(context)
                            .pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoadingPage()),
                                ((route) => false)));
                      },
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
