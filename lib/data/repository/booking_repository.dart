import 'package:dio/dio.dart';
import 'package:neo_tour/models/booking.dart';

 String token ='';

class BookingRepository {
  final Dio dio = Dio();

  BookingRepository() {
    dio.options = BaseOptions(
      baseUrl: '',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }


  Future<Booking?> book({required Booking bookingInfo}) async {

    Booking? bookedUser;

    String url='https://neotour-production-392c.up.railway.app/api/login';
    Map<String,dynamic> data = {
      "username": "muzaffar",
      "password": "1234"
    };

    try {
      Response loginResponse = await dio.post(
        url,
        data: data,
      );

      token=loginResponse.data["accessToken"];




      //bookedUser = Booking.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return bookedUser;
  }




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
