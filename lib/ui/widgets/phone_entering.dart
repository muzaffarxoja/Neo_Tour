import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';



class PhoneEntering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PhoneNumberInputWidget(),
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
  late PhoneNumber fullNumber;
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
                fullNumber = number;
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
            print('Phone number: ${fullNumber.phoneNumber}'); // Print full phone number to console
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}