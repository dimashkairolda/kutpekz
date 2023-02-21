import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/utils/utils.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}
// TODO check if user's phone number already registred

class _RegisterState extends State<Register> {
  TextEditingController phoneNumberController = TextEditingController();

  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(

      backgroundColor: const Color.fromRGBO(112, 166, 255, 1.0),
      body: SingleChildScrollView(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Onboard1.png'),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phoneNumberController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: const InputDecoration(
                hintText: 'Номер телефона',
                prefixIcon: Padding(
                    padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                    child: Text('+7 ')),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            MaterialButton(
              onPressed: () async {
                if (phoneNumberController.length != 10) {
                  showSnackBar(context, 'Incorrect number');
                } else {
                  // send data
                  sendPhoneNumber();
                }
              },
              color: const Color.fromRGBO(224, 239, 218, 1.0),
              child: const Text(
                'Войти',
              ),
              minWidth: 500,
            ),
          ],
        ),
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.signInWithPhone(context, getPhoneNumber());
  }

  String getPhoneNumber() {
    return '+7${phoneNumberController.text.trim()}';
  }
}
