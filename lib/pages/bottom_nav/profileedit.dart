import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:kutpekz/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';

//TODO make notifications

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  File? image;
  bool imageChanged = false;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
        imageChanged = true;
      });
    } on PlatformException catch (e) {
      showSnackBar(context, 'Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать профиль'),
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              heroTag: UniqueKey(),
              child: const Icon(
                Iconsax.arrow_left_2,
                size: 30,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              InkWell(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 52,
                      backgroundImage:
                          imageChanged ? Image.file(image!).image : ap.pfp,
                    ),
                    const Icon(
                      Iconsax.camera5,
                      size: 30,
                    ),
                  ],
                ),
                onTap: () {
                  pickImage();
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Padding(padding: EdgeInsets.only(right: 30)),
                      Text(
                        'Имя',
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: TextFormField(
                      controller: nameController,
                      // onChanged: (value){},
                      decoration: InputDecoration(
                        hintText: ap.userModel.name,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
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
                        "Сохранить",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                            color: Colors.white),
                      ),
                      onPressed: () async {
                        String? nameUpdate = nameController.text;
                        if (image != null) {
                          ap.saveUserData(
                              context: context,
                              userModel: ap.userModel,
                              profilePicture: image!,
                              onSuccess: () {});
                        }
                        if (nameUpdate.isEmpty) {
                          nameUpdate = ap.getCurrentName();
                        }

                        ap.updateName(context, nameUpdate!);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
