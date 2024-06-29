import 'package:dio/dio.dart';
import 'package:neo_tour/models/booking.dart';

class BookingRepository {
  final Dio dio = Dio();

  Future<Booking?> book({required Booking bookingInfo}) async {
    Booking? bookedUser;

    try {
      Response response = await dio.post(
        'https://neotour-production-392c.up.railway.app/api/bookings/add',
        data: bookingInfo.toJson(),
      );

      //print('User created: ${response.data}');

      //bookedUser = Booking.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return bookedUser;
  }
}
