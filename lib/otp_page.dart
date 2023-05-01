import 'dart:async';

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

  const OtpPage(
      {super.key,
      required this.verificationId,
      required this.phoneNumber,});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String? otpCode;
  bool isLoading = false;
  bool isOtpSent = true;
  var timer;
  int countdown = 30;
  bool isCountdownFinished = false;
  late final ap = Provider.of<AuthProvider>(context, listen: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startResendOtpTimer();
  }


  @override
  Widget build(BuildContext context) {
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
              const Padding(padding: EdgeInsets.only(top: 60)),
              const Image(
                image: AssetImage("assets/otp.png"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ('Код подтверждения \nОтправлен на номер ${widget.phoneNumber}'),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
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
                  onPressed: isCountdownFinished ? () {
                    ap.signInWithPhone(context, widget.phoneNumber);
                  } : null,
                  child: const Text("Отправить код еще раз")),
              !isCountdownFinished ? Text("00:${countdown.toString().padLeft(2,"0")}") : const SizedBox(height: 0,),
              const SizedBox(height: 45),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: CupertinoButton(
                  color: const Color.fromRGBO(98, 78, 234, 1),
                  borderRadius: BorderRadius.circular(10),
                  child: const Text(
                    "Подтвердить",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
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

  startResendOtpTimer() {
    isCountdownFinished = false;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown != 0) {
        countdown--;
      } else {
        countdown = 30;
        isCountdownFinished = true;
        timer.cancel();
      }
      setState(() {

      });
    });
  }

  void verifyOtp(BuildContext context, String userOtp) {

    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onError: (){
        setState(() {
          isLoading = false;
        });
      },
      onSuccess: () {
        ap.checkExistingUsers().then((value) async {
          setState(() {
            isLoading = false;
          });
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
