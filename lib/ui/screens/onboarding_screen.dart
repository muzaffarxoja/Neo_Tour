import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_tour/consts.dart';

import '../../main.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key})
      : super(
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
          width:double.infinity,
             child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.asset(
                  "assets/images/img_rectangle_19.png",
                  height: 480,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Winter \nVacation Trips",
                  maxLines: 2,
                  //overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0XFF141414),
                    fontSize: 36,
                    //fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: 6),
              Container(
                margin: EdgeInsets.only(left: 16),
                decoration: BoxDecoration(),
                child: Text(
                  "Enjoy your winter vacations with warmth\nand amazing sightseeing on the mountains.\nEnjoy the best experience with us!",
                  maxLines: null,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    //fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: double.maxFinite,
                height: 52,
                margin: EdgeInsets.only(left: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor, //Color(0XFF6A62B6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        24,
                      ),
                    ),
                    visualDensity: const VisualDensity(
                      vertical: -4,
                      horizontal: -4,
                    ),
                    padding: EdgeInsets.only(
                      left: 30,
                      top: 16,
                      bottom: 16,
                    ),
                  ),
                  onPressed: () {
                    context.go(place_screen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Let’s Go!",
                        style: TextStyle(
                          color: AppColorSchemes.lightColorScheme.onPrimary ,
                          fontSize: 16,
                          //fontFamily: 'SF Pro Display',

                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 18),
                        child: Image.asset(
                          "assets/icons/arrow_right_long.png",
                          height: 16,
                          width: 36,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4)
            ],
          ),
        ),
      ),
    );
  }
}
