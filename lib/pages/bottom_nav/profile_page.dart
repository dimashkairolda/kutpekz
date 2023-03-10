import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/pages/loading_page.dart';
import 'package:provider/provider.dart';
import 'package:kutpekz/main.dart';

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
              height: 60,
            ),
            Text(
              'Профиль',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {},
              child: CircleAvatar(
                radius: 47.5,
                backgroundImage: NetworkImage(ap.userModel.profilePicture),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Здравстуйте, ${ap.userModel.name}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 50,
            ),
            Divider(
              color: Colors.grey.shade300,
              endIndent: 30,
              indent: 30,
              thickness: 1.25,
            ),

            SizedBox(
              height: 10,
            ),


                Column(
                  children: [
                  ListTile(
                    contentPadding:EdgeInsets.only(left: 30),
                    leading: Icon(Icons.person, color: Colors.black,),
                    title: Text('Редактировать Профиль', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                    onTap: (){
                      Navigator.pushNamed(context, '/profile_edit');
                    },
                  ),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30),
                      leading: Icon(Icons.credit_card_rounded, color: Colors.black,),
                      title: Text('Оплата', style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                      onTap: (){},
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30),
                      leading: Icon(Icons.language, color: Colors.black,),
                      title: Text('Язык',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                      onTap: (){
                        Navigator.pushNamed(context, '/language_edit');
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
            SizedBox(
              height: 50,
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
