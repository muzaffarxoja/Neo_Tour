import 'package:flutter/material.dart';
import 'package:neo_tour/consts.dart';
import 'package:provider/provider.dart';
import 'package:neo_tour/ui/screens/onboarding_screen.dart';
import 'package:neo_tour/ui/screens/place_screen.dart';
import 'package:neo_tour/ui/widgets/booking_modal_sheet.dart';
import 'package:neo_tour/ui/widgets/phone_entering.dart';
import 'package:neo_tour/provider/counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Counter(),
    child:  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColorSchemes.lightColorScheme.background,
        disabledColor: AppColorSchemes.lightColorScheme.secondary ,
        colorScheme: AppColorSchemes.lightColorScheme,
        fontFamily: 'SF Pro Display',
      ),
      darkTheme: ThemeData(
        colorScheme: AppColorSchemes.darkColorScheme,
        fontFamily: 'SF Pro Display',
      ),
      themeMode: ThemeMode.system,
      //home: const OnboardingScreen(),
      // home: const PlaceScreen(),
      // home: PhoneEntering(),
      home: BookingModalSheet(),
    ),);
  }
}