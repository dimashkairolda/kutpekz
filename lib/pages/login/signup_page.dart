import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 140)),
            const Image(
              image: AssetImage("assets/login.png"),
            ),
            const Padding(padding: EdgeInsets.only(top: 70)),
            const Center(
              child: Text(
                "Введите ваш номер телефона",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
            const Center(
              child: Text(
                "Мы отправим вам 6-и значный проверочный код",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Text(
                      'Номер телефона',
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ),
                  GestureDetector(
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneNumberController,
                      style:  TextStyle(
                          fontSize: 16, fontFamily: "San Francisco"),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: const InputDecoration(
                        filled: true,
                        isDense: true,
                        prefixIcon: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 2),
                          child: Text(
                            '+7 ',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        prefixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent, style: BorderStyle.none),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent, style:  BorderStyle.none),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
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
                onPressed: () async {
                  if (phoneNumberController.length != 10) {
                    showSnackBar(
                      context,
                      'Некорректный номер',
                    );
                  } else {
                    // send data
                    sendPhoneNumber();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  String getPhoneNumber() {
    return '+7${phoneNumberController.text.trim()}';
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.signInWithPhone(context, getPhoneNumber());
  }
}

