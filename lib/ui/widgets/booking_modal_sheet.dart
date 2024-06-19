import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:neo_tour/provider/my_phone_number.dart';
import 'package:provider/provider.dart';

import '../../provider/counter_and_number.dart';


class BookingModalSheet extends StatelessWidget {
  const BookingModalSheet({Key? key}) : super(key: key);



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
                  const TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  const TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Age'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

            Consumer<MyPhoneNumber>(
              builder: (context, myPhoneNumber, child) {
                return Text(myPhoneNumber.fullNumberPr.phoneNumber.toString());
              },
            ),

            CounterWidget(),

                  ElevatedButton(onPressed: () {
                    print('Phone number: {fullNumber.phoneNumber}');
                  }, child: const Text('Submit'),),

                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => show_booking_modal_sheet(context),
      ),
    );
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
  //PhoneNumber fullNumber = PhoneNumber();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(30.0), // Circular border
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                //fullNumber = number;
                context.read<MyPhoneNumber>().fullNumberPr = number;
                print(number.phoneNumber); // Print full phone number to console
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
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Perform validation or other actions here
            //print('Phone number: ${fullNumber.phoneNumber}'); // Print full phone number to console
          },
          child: Text('Submit'),
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

    return  Row(

          children: [
            IconButton(
              onPressed: counter.increment,
              icon: const Icon(Icons.add),),


            IconButton(
              onPressed: counter.decrement,
              icon: const Icon(Icons.add_chart),),


          ]
      );
  }
}

