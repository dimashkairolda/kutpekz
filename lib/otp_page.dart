import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/home_page.dart';
import 'package:kutpekz/pages/user_information_page.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  const OtpPage({super.key, required this.verificationId, required this.phoneNumber});

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
        child: isLoading == true ?
        const Center(
          child: CircularProgressIndicator(color: Colors.grey,),
        ) : Column(
          children: [
            SizedBox(height: 120),
            Text(('Код подтверждения отправлен на ${widget.phoneNumber}')),
            SizedBox(height: 60),
            Pinput(
              length: 6,
              showCursor: true,
              defaultPinTheme: PinTheme(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)
                ),
              ),
              onCompleted: (value) {
                setState(() {
                  otpCode = value;
                });
              },
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 320,
              child: Material(
                elevation: 5,
                color: Colors.grey,
                borderRadius: BorderRadius.circular(32.0),
                child: MaterialButton(
                  child: Text(
                    "Подтвердить",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                  ),
                  onPressed: () {
                    verifyOtp(context, otpCode!);
                  },
                ),
              ),
            )
          ],
        )
      ),
    );
  }
  void verifyOtp(BuildContext context, String userOtp){
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: (){
        ap.checkExistingUsers().then((value) async {
          if(value){
            // user exists
            print('User Exists');
            ap.getDataFromStorage().then((value)
            => ap.saveUserDataPreferences().then((value)
            => ap.setSignIn().then((value)
            => Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false)))
            );
          }
          else{
            // new user
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => const UserInformationPage()),
                    (route) => false);
          }
        });
      },
    );
  }
}
