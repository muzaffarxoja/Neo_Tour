import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:neo_tour/models/booking.dart';
import 'package:neo_tour/provider/my_phone_number.dart';
import 'package:provider/provider.dart';

import '../../data/repository/booking_repository.dart';
import '../../provider/counter_and_number.dart';

class BookingModalSheet extends StatelessWidget {
  BookingModalSheet({Key? key}) : super(key: key);
  TextEditingController commentController = TextEditingController();

  String _phoneToPost='';
  // String _commentToPost='';
  // int _peopleAmountToPost=0;

  void postBooking(
  { required String phone, required String comment,required int peopleAmount}) {
    Booking bookingData = Booking(
        //id: 1,
        phone: '+998998809090',
        comment: 'hgfh',
        people_amount: 3,
        //username: 'username',
        tourId: 6
    );

     //debugPrint(bookingData.toJson().toString());
    BookingRepository().book(bookingInfo: bookingData);
  }

  // This function is triggered when the floating buttion is pressed
  void show_booking_modal_sheet(BuildContext contex) {
    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: contex,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Info',
              style: TextStyle(
                  color: Color(0XFF141414),
                  fontSize: 24,
                  //fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Text(
              'To submit an application for a tour reservation, you need to fill in your information and select the number of people for the reservation',
              style: TextStyle(
                  color: Color(0XFF141414),
                  fontSize: 14,
                  //fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 12),
            Text(
              'Phone number',
              style: TextStyle(
                  color: Color(0XFF888888),
                  fontSize: 14,
                  //fontFamily: 'SF Pro Display',
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
                  //fontFamily: 'SF Pro Display',
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
                    hintStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    hintText: 'Write your wishes to trip...'),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff6A62B7)),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Consumer<MyPhoneNumber>(
              builder: (context, myPhoneNumber, child) {
                return Text(myPhoneNumber.fullNumberPr.phoneNumber.toString());
              },
            ),
            const SizedBox(height: 12),
            Text(
              'Number of people',
              style: TextStyle(
                  color: Color(0XFF888888),
                  fontSize: 14,
                  //fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400),
            ),
            CounterWidget(),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF6A62B6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      24,
                    ),
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
                  postBooking(phone: BookingModalSheet()._phoneToPost, peopleAmount: Counter().count, comment: commentController.text);
                  Navigator.of(ctx).pop();
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 18,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
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
  PhoneNumber fullNumber = PhoneNumber();

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
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                //fullNumber = number;
                context.read<MyPhoneNumber>().fullNumberPr = number;
                fullNumber = number;
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
                    fontFamily: 'SF Pro Display',
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
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
