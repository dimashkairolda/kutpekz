import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:provider/provider.dart';

//TODO make notifications

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);
  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Widget build(BuildContext context) {

    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
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
                    children: [
                      Padding(padding: EdgeInsets.only(right: 30)),

                      Text('Имя',)],),
                  Padding(padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: TextFormField(
                      controller: nameController,
                      // onChanged: (value){},
                      decoration:  InputDecoration(
                        hintText: ap.userModel.name,
                        border: OutlineInputBorder(),
                      )
                      ,),

                  ),
                  Padding(padding: EdgeInsets.only(bottom: 50)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(right: 30)),

                      Text('Номер телефона',)],),
                  Padding(padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                      ],
                      decoration: InputDecoration(
                        hintText: ap.userModel.phoneNumber,
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.85,
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
                        onPressed: () async {
                          String? nameUpdate = nameController.text;

                          if(nameUpdate.isEmpty){
                            nameUpdate = ap.getCurrentName();
                          }

                          ap.updateName(context, nameUpdate!);

                        },
                      ),
                    ),
                  ))
            ],
          ),
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
                child: Icon(Icons.chevron_left, size: 30,),
                backgroundColor: Colors.white,
              ),
            ),),]
        ,
      )
      ,
    );
  }
}

