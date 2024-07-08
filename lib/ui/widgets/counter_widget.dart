import 'package:flutter/material.dart';
import 'package:neo_tour/provider/counter_and_number.dart';
import 'package:provider/provider.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);

    return Row(
      children: [
        Container(
          height: 36,
          width: 104,
          decoration: BoxDecoration(
              color: const Color(0xffF3F3F3),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                height: 36,
                width: 29,
                decoration: BoxDecoration(
                    color: const Color(0xff897CFF),
                    borderRadius: BorderRadius.circular(10)),
                child: GestureDetector(
                  onTap: () {
                    if (counter.count > 0) {
                      counter.decrement();
                    }
                  },
                  child: const Icon(color: Colors.white, Icons.remove),
                ),
              ),
              Text(
                counter.count.toString(),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
              Container(
                alignment: Alignment.center,
                height: 36,
                width: 29,
                decoration: BoxDecoration(
                    color: const Color(0xff897CFF),
                    borderRadius: BorderRadius.circular(10)),
                child: GestureDetector(
                  onTap: () {
                    if (counter.count < 5) {
                      counter.increment();
                    }
                  },
                  child: const Icon(color: Colors.white, Icons.add),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Image.asset(
          'assets/icons/people.png',
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 5),
        Text(
          '${counter.count.toString()} people',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
