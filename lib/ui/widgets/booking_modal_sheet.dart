import 'package:flutter/material.dart';
import 'package:neo_tour/provider/my_phone_number.dart';
import 'package:provider/provider.dart';

import '../../provider/counter_and_number.dart';
import 'counter_widget.dart';
import 'custom_phone_number_input.dart';

class BookingModalSheet extends StatelessWidget {
  BookingModalSheet({super.key, required this.onBooking});

  final void Function ({
    required String phone,
    required int peopleAmount,
    required String comment,
  }) onBooking;

  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 15),
      child: Consumer<MyPhoneNumber>(
        builder: (_, myPhoneNumber, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Info',
                style: TextStyle(
                    color: Color(0XFF141414),
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              const Text(
                'To submit an application for a tour reservation, you need to fill in your information and select the number of people for the reservation',
                style: TextStyle(
                    color: Color(0XFF141414),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 12),
              const Text(
                'Phone number',
                style: TextStyle(
                    color: Color(0XFF888888),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 3),
              const PhoneNumberInputWidget(),
              const SizedBox(height: 12),
              const Text(
                'Commentaries to trip',
                style: TextStyle(
                    color: Color(0XFF888888),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 3),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff6A62B7)),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: TextField(
                  controller: commentController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                      hintText: 'Write your wishes to trip...'),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Number of people',
                style: TextStyle(
                    color: Color(0XFF888888),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const CounterWidget(),
              const SizedBox(height: 50),
              SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF6A62B6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    visualDensity: const VisualDensity(
                      vertical: -4,
                      horizontal: -4,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 14,
                    ),
                  ),
                  onPressed: () {
                    final phone =
                        myPhoneNumber.fullNumberPr.phoneNumber ?? '';
                    final comment = commentController.text;
                    final peopleAmount =
                        Provider.of<Counter>(context, listen: false).count;

                    onBooking(
                      phone: phone,
                      peopleAmount: peopleAmount,
                      comment: comment,
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Color(0XFFFFFFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}