import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart'; // تأكدي من استيراد get العام
// استوردي الـ StorageService الخاص بكِ هنا (عدلي المسار حسب مشروعك)

import 'Screens/EventDetails/AddEssentialItem.dart';
import 'Screens/EventDetails/CompleteBooking.dart';
import 'Screens/EventDetails/EventCardDetailsBookingScreen.dart';
import 'Screens/EventDetails/EventDetails.dart';
import 'Screens/EventDetails/EventType.dart';
import 'Screens/EventPreparing/ALahazej/ALahazej.dart';
import 'Screens/EventPreparing/Canva/ChooseScreen.dart';
import 'Screens/EventPreparing/EventEssentials/IfEmptyEssentials.dart';
import 'Screens/EventPreparing/IfEmpty.dart';
import 'Screens/EventPreparing/IfFirst.dart';
import 'Screens/EventPreparing/MyEvents.dart';
import 'Screens/EventPreparing/TodoList1.dart';
import 'Screens/EventPreparing/TodoList5.dart';
import 'Screens/ServicesProvider/EventDetailsHome(visit)/EventDetailsHome(visit).dart';
import 'Screens/auth/LogIn.dart';
import 'Screens/auth/OtpScreen.dart';
import 'Screens/auth/Users/UserRegister1.dart';
import 'Screens/auth/finalReset.dart';
import 'Screens/auth/resetPassword.dart';
import 'Screens/home-layout/Home-layout.dart';
import 'Screens/home-layout/Home.dart';
import 'Screens/intro/start.dart';
import 'Shared/sharedPreferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool loggedIn = await StorageService.isLoggedIn();
  bool hasToken = await StorageService.hasToken();

  runApp(MyApp(isUserLoggedIn: loggedIn && hasToken));
}

class MyApp extends StatelessWidget {
  final bool isUserLoggedIn;

  const MyApp({super.key, required this.isUserLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Farha App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'BahijTheSansArabic',
        snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(
            fontFamily: 'BahijTheSansArabic',
            fontSize: 14,
          ),
        ),
      ),

      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

     home:isUserLoggedIn ? const HomeLayout() : const Start(),
    );
  }
}