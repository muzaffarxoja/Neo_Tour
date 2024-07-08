import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:neo_tour/provider/my_phone_number.dart';
import 'package:provider/provider.dart';

class PhoneNumberInputWidget extends StatefulWidget {
  const PhoneNumberInputWidget({super.key});

  @override
  State<PhoneNumberInputWidget> createState() => _PhoneNumberInputWidgetState();
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
            border: Border.all(color: const Color(0xff6A62B7)),
            borderRadius: BorderRadius.circular(30.0), // Circular border
          ),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                context.read<MyPhoneNumber>().fullNumberPr = number;
              },
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                useEmoji: true,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: const TextStyle(color: Colors.black),
              initialValue: intNumber,
              textFieldController: controller,
              formatInput: true,
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              inputDecoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
