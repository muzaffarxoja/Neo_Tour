import 'package:dio/dio.dart';
import 'package:neo_tour/models/booking.dart';

const token = 'eyJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJzZWxmIiwic3ViIjoicnJyciIsImlhdCI6MTcxOTg0OTQyNywicm9sZXMiOiJVU0VSIn0.dlOY7okRCMaFX8XcnM46SLNdls_0CxRw7cy2_vrRy6lrnBiSD_d79ZOMemv-lPIRFUy0HbVgtx9HeI5SwC7wxhppBjalACi5fz1TpnpnOpglCh0JruL3XrlPA4xGADaHOOlLmAXEaHLr6_EkDsJD5Lj2DB_Dnp_Dq5rwvbDBztbPw15mTdvnyGk1_bpsd0lH1FMYTRdr4fIrFqdAxAWPPUe34ZzDlt-sY6g2mItG-bMdtloT4dHrPsvqTstjuAzocHbP_w8Xp3adEXJsq9hPISvV0h4cnWl4fb53Mj3w8Q0X1Go4ssODW1Q7cHuY0-Ji4nmlkViC0heGEh9T5uWFHg';

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
