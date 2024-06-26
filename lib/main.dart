import 'package:flutter/material.dart';
import 'package:neo_tour/consts.dart';
import 'package:neo_tour/provider/my_phone_number.dart';
import 'package:neo_tour/ui/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:neo_tour/ui/screens/onboarding_screen.dart';
import 'package:neo_tour/ui/screens/place_screen.dart';
// import 'package:neo_tour/ui/widgets/booking_modal_sheet.dart';
// import 'package:neo_tour/ui/widgets/phone_entering.dart';
import 'package:neo_tour/provider/counter_and_number.dart';
import 'package:go_router/go_router.dart';

import 'models/place.dart';



const String onboarding_screen = '/onboarding_screen';
const String place_screen = '/place_screen';
const String main_screen = '/main_screen';



final _router = GoRouter(
  initialLocation: onboarding_screen,
  //initialLocation: filter,

  routes: [
    GoRoute(
      path: onboarding_screen,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: place_screen,
      builder: (context, state) =>PlaceScreen(singlePlace: state.extra as Place),
    ),

    GoRoute(
      path: main_screen,
      builder: (context, state) => const MainScreen(),
    ),
    ],
);



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(
            create: (context) => Counter()),
        ChangeNotifierProvider(
            create: (context) => MyPhoneNumber()),
        ],
    child:  MaterialApp.router(
      routerConfig: _router,
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
      // home:  PlaceScreen(),
      // home: PhoneEntering(),
      //home: BookingModalSheet(),
    ),);
  }
}