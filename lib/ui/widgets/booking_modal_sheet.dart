import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:neo_tour/models/booking.dart';
import 'package:neo_tour/provider/my_phone_number.dart';
import 'package:provider/provider.dart';

import '../../data/repository/booking_repository.dart';
import '../../provider/counter_and_number.dart';
import 'package:neo_tour/ui/widgets/booking_alert.dart';

class BookingModalSheet extends StatelessWidget {
  BookingModalSheet({Key? key, required this.id}) : super(key: key);

  final TextEditingController commentController = TextEditingController();
  final int id;

  void postBooking(
      {required String phone, required String comment, required int peopleAmount}) async {
    BookingRepository bookingRepository = BookingRepository();

    Booking bookingData = Booking(
      phone: phone,
      comment: comment,
      people_amount: peopleAmount,
      tourId: id,
    );

    var result = await bookingRepository.book(bookingInfo: bookingData);
    if (result != null) {
      print("Booking succeeded: $result");
      debugPrint('${result['tourId']}');
    } else {
      print("Booking failed");
    }
  }

  void _showBookingAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('The Tour has been booked.'),
          actions: [
            Center(
              child: SizedBox(
                width: double.maxFinite, // Set the width here
                height: 35, // Set the height here
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
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(
                      color: Color(0XFFFFFFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }



  void show_booking_modal_sheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
        child: Consumer<MyPhoneNumber>(
          builder: (context, myPhoneNumber, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Info',
                  style: TextStyle(
                      color: Color(0XFF141414),
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Text(
                  'To submit an application for a tour reservation, you need to fill in your information and select the number of people for the reservation',
                  style: TextStyle(
                      color: Color(0XFF141414),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 12),
                Text(
                  'Phone number',
                  style: TextStyle(
                      color: Color(0XFF888888),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 3),
                PhoneNumberInputWidget(),
                const SizedBox(height: 12),
                Text(
                  'Commentaries to trip',
                  style: TextStyle(
                      color: Color(0XFF888888),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 3),
                Container(
                  child: TextField(
                    controller: commentController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                        hintText: 'Write your wishes to trip...'),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff6A62B7)),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
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
                      final phone = myPhoneNumber.fullNumberPr.phoneNumber ?? '';
                      final comment = commentController.text;
                      final peopleAmount = Provider.of<Counter>(context, listen: false).count;

                      postBooking(
                        phone: phone,
                        peopleAmount: peopleAmount,
                        comment: comment,
                      );

                      Navigator.of(ctx).pop();

                      _showBookingAlert(context);


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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

class PhoneNumberInputWidget extends StatefulWidget {
  @override
  _PhoneNumberInputWidgetState createState() => _PhoneNumberInputWidgetState();
}

class _PhoneNumberInputWidgetState extends State<PhoneNumberInputWidget> {
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'KG'; // Initial selection
  PhoneNumber intNumber = PhoneNumber(isoCode: 'KG');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xff6A62B7)),
            borderRadius: BorderRadius.circular(30.0), // Circular border
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                context.read<MyPhoneNumber>().fullNumberPr = number;
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                useEmoji: true,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: intNumber,
              textFieldController: controller,
              formatInput: true,
              keyboardType: TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              inputDecoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);

    return Row(
      children: [
        Container(
          height: 36,
          width: 104,
          decoration: BoxDecoration(
              color: Color(0xffF3F3F3),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    if (counter.count > 0) {
                      counter.decrement();
                    }
                  },
                  child: Icon(color: Colors.white, Icons.remove),
                ),
                height: 36,
                width: 29,
                decoration: BoxDecoration(
                    color: Color(0xff897CFF),
                    borderRadius: BorderRadius.circular(10)),
              ),
              Text(
                counter.count.toString(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900),
              ),
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    if (counter.count < 5) {
                      counter.increment();
                    }
                  },
                  child: Icon(color: Colors.white, Icons.add),
                ),
                height: 36,
                width: 29,
                decoration: BoxDecoration(
                    color: Color(0xff897CFF),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Image.asset(
          'assets/icons/people.png',
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 5),
        Text(
          '${counter.count.toString()} people',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
