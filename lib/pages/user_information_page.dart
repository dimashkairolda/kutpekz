import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/custom_button.dart';
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
      backgroundColor: Color.fromRGBO(112, 166, 255, 1.0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 5),
          child: isLoading == true ?
          const Center(
            child: CircularProgressIndicator(color: Colors.grey,),
          ) : Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    selectImage();
                  },
                  child: image == null ?
                  const CircleAvatar(
                    backgroundColor: Colors.amber,
                    radius: 50,
                    child: Icon(Icons.account_circle, size: 50, color: Colors.white),
                  )
                  : CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 50,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      // name
                      textField(hintText: 'Name', icon: Icons.account_circle, inputType: TextInputType.name, maxLines: 1, controller: nameController),
                      // email
                      textField(hintText: 'Email', icon: Icons.email, inputType: TextInputType.emailAddress, maxLines: 1, controller: emailController),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomButton(
                          text: 'Continue',
                          onPressed: (){
                            storeData();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textField({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller
  }) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: TextFormField(
          maxLines: maxLines,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.amber
              ),
              child: Icon(icon,size:20, color: Colors.white,),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.amber),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.amber),
            ),
            hintText: hintText,
            alignLabelWithHint: true,
            border: InputBorder.none,
            fillColor: Colors.amber.shade50,
            filled: true
          ),
        ),
    );
  }

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
        phoneNumber: "",
        email: emailController.text.trim(),
        name: nameController.text.trim(),
        profilePicture: "",
        createdAt: "",
        uid: "",
        password: "",
    );
    if(image != null){
      ap.saveUserData(
        context: context,
        userModel: userModel,
        profilePicture: image!,
        onSuccess: (){
          ap.saveUserDataPreferences().then((value)
          => ap.setSignIn().then((value)
          => Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false)
          ));
        }
      );
    }
    else{
      // use default image
      print('Update your profile picture');
    }
  }
}
