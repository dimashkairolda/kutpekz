import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/custom_button.dart';
import 'package:kutpekz/history_model.dart';
import 'package:kutpekz/home_page.dart';
import 'package:kutpekz/user_model.dart';
import 'package:kutpekz/utils/utils.dart';
import 'package:provider/provider.dart';

class UserInformationPage extends StatefulWidget {
  const UserInformationPage({Key? key}) : super(key: key);

  @override
  State<UserInformationPage> createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<UserInformationPage> {
  File? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
  }

  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 5),
        child: isLoading == true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                    CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 60)),
                  Text(
                    'Введите данные',
                    style:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                  Padding(padding: EdgeInsets.only(top: 40)),
                  InkWell(
                    onTap: () {
                      selectImage();
                    },
                    child: image == null
                        ? CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            radius: 50,
                            child: Icon(
                              Icons.account_circle,
                              size: 100,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(image!),
                            radius: 50,
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 20)),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          child: Text(
                            'Имя',
                            style:
                            TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ),
                        GestureDetector(
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            style: TextStyle(
                                fontSize: 16, fontFamily: "San Francisco"),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                            ],
                            decoration: const InputDecoration(
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent,
                                    style: BorderStyle.none),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent,
                                    style: BorderStyle.none),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 120,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: CupertinoButton(
                      color: Color.fromRGBO(98, 78, 234, 1),
                      borderRadius: BorderRadius.circular(10),
                      child: const Text(
                        "Отправить код",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        if(nameController.text.isEmpty){
                          showSnackBar(context, "Введите свое имя");
                          return;
                        }
                        else if(nameController.text.length < 2){
                          showSnackBar(context, "Имя должно быть не меньше двух символов");
                          return;
                        }
                        else{
                          storeData();
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    await ap.getCarWashesFromStorage();
    List<bool> favs = List.filled(ap.carWashes.length, false, growable: true);
    HistoryModel hist =
        HistoryModel(names: [], addresses: [], dates: [], times: []);
    UserModel userModel = UserModel(
      phoneNumber: "",
      email: "",
      name: nameController.text.trim(),
      profilePicture: "",
      createdAt: "",
      uid: "",
      isFavourite: favs,
      history: hist,
    );
    if (image != null) {
      ap.saveUserData(
          context: context,
          userModel: userModel,
          profilePicture: image!,
          onSuccess: () {
            ap.saveUserDataPreferences().then((value) => ap.setSignIn().then(
                (value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false)));
          });
    } else {
      // use default image
      print('Продолжить без аватара?');
    }
  }
}
