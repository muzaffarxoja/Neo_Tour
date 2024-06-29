import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_tour/data/repository/places_repository.dart';
import 'package:neo_tour/models/tour.dart';
import 'package:neo_tour/ui/widgets/booking_modal_sheet.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';
import '../../models/place.dart';
import '../../models/review.dart';

class PlaceScreen extends StatefulWidget {
  final Place singlePlace;


  const PlaceScreen({super.key, required this.singlePlace});

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {

  late final Tour _detail;
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    _loadTourDetail(widget.singlePlace.id.toString());
  }

  void _loadTourDetail(String id) async {
    Tour detail = await PlacesRepository().getPlaceDetail(id);

    setState(() {
      _detail = detail;
      _isLoading = false;


    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFFFFF),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.network(
                widget.singlePlace.image,
                height: 289,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: _buildMountFujiSection(context, _detail, _isLoading),
            ),
            Positioned(
              top: 20, // Adjust the top position to place the header correctly
              left: 15,
              child: Row(
                children: [
                  SizedBox(
                    height: 24, // Set the desired height
                    width: 24, // Set the desired width
                    child: IconButton(
                      padding: EdgeInsets.zero, // Remove default padding
                      iconSize: 24, // Adjust the icon size
                      onPressed: () => context.pop(),
                      //onPressed: () => context.go(onboarding_screen),
                      icon: Image.asset('assets/icons/back_button.png'),
                    ),
                  ),
                  const SizedBox(width: 5),
                  // Add some space between the icon and the text
                  const Text(
                    "Back",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildMountFujiSection(BuildContext context, Tour detail , bool loading) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }


    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: 250,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0XFFFFFFFF),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 40,
        ),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              detail.name,
              style: TextStyle(
                color: Color(0XFF141414),
                fontSize: 24,
                // fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.maxFinite,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 14,
                    width: 14,
                    child: Image.asset(
                      "assets/icons/location.png",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      '${detail.location}, ${detail.country}',
                      style: TextStyle(
                        color: Color(0XFF141414),
                        fontSize: 12,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Description",
              style: TextStyle(
                color: Color(0XFF141414),
                fontSize: 20,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              detail.description,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0XFF141414),
                fontSize: 16,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              "Reviews",
              style: TextStyle(
                color: Color(0XFF141414),
                fontSize: 20,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ...detail.reviews.map((review) => _MyBuildTextReview(review)).toList(),
            _MyBuildImageRewiew(detail.images),
            const SizedBox(height: 24),
            _buildBookNowButton(context),
            const SizedBox(height: 24),

          ],
        ),
      ),
    );
  }




  Widget _MyBuildTextReview(Review review) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                  child: Image.network(
                    review.imageUrl,
                    height: 24,
                    width: 24,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      review.username,
                      style: TextStyle(
                        color: Color(0XFF141414),
                        fontSize: 16,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
         // const SizedBox(height: 2),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              review.review,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0XFF141414),
                fontSize: 16,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _MyBuildImageRewiew(List<String> images) {
    // if (loading) {
    //   return const Center(child: CircularProgressIndicator());
    // }
    //
    if (images.isEmpty) {
      return const Center(child: Text('No places available'));
    }

    return Container(
      height: 130,
      width: double.maxFinite,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          String img = images[index];
          return Container(
            width: 130,
            height: 100,
            margin: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: GestureDetector(
                child: Image.network(
                  img, // Assuming Place has an imageUrl property
                  fit: BoxFit.cover,
                ),

              ),
            ),
          );
        },
      ),
    );
  }




  /// Section Widget
  Widget _buildBookNowButton(BuildContext context) {
    return SizedBox(
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
        onPressed: () =>  BookingModalSheet().show_booking_modal_sheet(context),
        child: const Text(
          "Book Now",
          style: TextStyle(
            color: Color(0XFFFFFFFF),
            fontSize: 18,
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }



 }
