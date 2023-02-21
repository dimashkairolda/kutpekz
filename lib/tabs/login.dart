import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:provider/provider.dart';
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    String getPhoneNumber() {
      return "+7${phoneNumberController.text.trim()}";
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(112, 166, 255, 1.0),
      body: Padding(padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            Image.asset('assets/Onboard2.png'),
            TextFormField(style: TextStyle(fontFamily: 'Inter'),
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                hintText: 'Номер телефона',
                prefixIcon: Padding(padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                    child: Text('+7 ')),

              ),
            ),
            TextField(style: TextStyle(fontFamily: 'Inter'),
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Пароль',
                prefixIcon: Padding(padding: EdgeInsets.fromLTRB(10, 12, 0, 0)),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            TextButton(onPressed: () {
              Navigator.pushNamed(context, '/reset');
            },
              child: Text(
                'Забыли пароль?', style: TextStyle(color: Colors.black),),),

            Padding(padding: EdgeInsets.only(bottom: 20)),
            MaterialButton(onPressed: () async {

            },
              color: Color.fromRGBO(224, 239, 218, 1.0),
              child: Text('Войти', style: TextStyle(fontFamily: 'Inter',),),
              minWidth: 500,


            ),


          ],
        ),
      ),
    );
  }
}
