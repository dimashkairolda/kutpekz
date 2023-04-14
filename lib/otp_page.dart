import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/pages/bottom_nav//home_page.dart';
import 'package:kutpekz/pages/login/user_information_page.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  final bool isChange;

  const OtpPage(
      {super.key,
      required this.verificationId,
      required this.phoneNumber,
      required this.isChange});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: Center(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              )
            : SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 60)),
              Image(
                image: AssetImage("assets/otp.png"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ('Код подтверждения \nОтправлен на номер ${widget.phoneNumber}'),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Pinput(
                      length: 6,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.secondary,
                            border: Border.all(color: Colors.grey)),
                      ),
                      onCompleted: (value) {
                        setState(() {
                          otpCode = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {}, child: Text("Отправить код еще раз")),
              const SizedBox(height: 45),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: CupertinoButton(
                  color: Color.fromRGBO(98, 78, 234, 1),
                  borderRadius: BorderRadius.circular(10),
                  child: const Text(
                    "Подтвердить",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    verifyOtp(context, otpCode!);
                  },
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        )
      ),
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    if (widget.isChange) {
      ap.getCredentials(context, widget.verificationId, userOtp);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
      return;
    }

    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        ap.checkExistingUsers().then((value) async {
          if (value) {
            // user exists
            ap.getDataFromStorage().then((value) => ap
                .saveUserDataPreferences()
                .then((value) => ap.setSignIn().then((value) =>
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (route) => false))));
          } else {
            // new user
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserInformationPage()),
                (route) => false);
          }
        });
      },
    );
  }
}
