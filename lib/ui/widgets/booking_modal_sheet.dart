import 'package:flutter/material.dart';

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
              ElevatedButton(onPressed: () {}, child: const Text('Submit'))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => show_booking_modal_sheet(context),
      ),
    );
  }
}

