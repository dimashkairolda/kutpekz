import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/pages/bottom_nav/languageedit.dart';
import 'package:kutpekz/pages/bottom_nav/profileedit.dart';
import 'package:kutpekz/pages/loading_page.dart';
import 'package:kutpekz/pages/onboard_pages/onboard_page_1.dart';
import 'package:kutpekz/pages/onboard_pages/onboard_page_2.dart';
import 'package:kutpekz/pages/onboard_pages/onboard_page_3.dart';
import 'package:kutpekz/pages/signup_page.dart';
import 'package:kutpekz/pages/password_reset_page.dart';
import 'package:kutpekz/pages/car_wash_detail.dart';
import 'package:kutpekz/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:kutpekz/pages/booking.dart';
import 'package:kutpekz/pages/date.dart';

import 'generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'Kutpe-App',
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCOtjxBQyaleG6nD8D2xqEbWNTvoKCekJk',
          appId: '1:760528812857:android:3e2af3845231555b9946e8',
          messagingSenderId: '760528812857',
          projectId: 'kutpe-kz',
          storageBucket: 'kutpe-kz.appspot.com/'));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: [Locale('kk'), Locale('ru')],
        path: 'assets/translations',
        fallbackLocale: Locale('ru'),
        assetLoader: CodegenLoader(),
        // saveLocale: true,
        useOnlyLangCode: true,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: const [
        Locale('ru'),
        Locale('kk'),
      ],
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: MyTheme.light,
      themeMode: ThemeMode.system,
      darkTheme: MyTheme.dark,
      title: 'Kutpe-Kz',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingPage(),
        '/onboard1': (context) => const FirstOnboardPage(),
        '/onboard2': (context) => const SecondOnboardPage(),
        '/onboard3': (context) => const ThirdOnboardPage(),
        '/signup': (context) => const SignUp(),
        '/reset': (context) => const ResetPassword(),
        '/profile_edit': (context) => const ProfileEdit(),
        '/language_edit': (context) => const LanguageEdit(),
        '/profile_page': (context) => const ProfileEdit(),
        '/booking': (context) => const Booking(),
        '/datepicker': (context) => const DatePicker(),
      },
    );
  }
}
