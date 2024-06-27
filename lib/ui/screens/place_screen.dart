import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_tour/data/repository/places_repository.dart';
import 'package:neo_tour/models/place_detail.dart';
import 'package:neo_tour/models/review.dart';
import 'package:neo_tour/models/tour.dart';
import 'package:neo_tour/ui/widgets/booking_modal_sheet.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';
import '../../models/place.dart';

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

  // late final PlaceDetail placeDetail;
  //
  // @override
  // void initState() {
  //   _init();
  //   super.initState();
  // }
  //
  // Future<void> _init() async {
  //   placeDetail = await PlacesRepository()
  //       .getPlaceDetail(widget.singlePlace.id.toString());
  //   setState(() {});
  //   print(placeDetail);
  // }

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
              child: _buildMountFujiSection(context, _detail , _isLoading),
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
  Widget _buildMountFujiSection(
      BuildContext context, Tour detail, bool loading, ) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }
    // if (detail.isEmpty) {
    //   return const Center(child: Text('No places available'));
    // }
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
            _MyBuildViewSection(context, detail.reviews),

            //_buildReviewSection(context),
            const SizedBox(height: 24),
            _buildBookNowButton(context),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 124,
                child: Divider(
                  height: 4,
                  thickness: 4,
                  color: Color(0XFFC8CBD2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackBackSection(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/img_rectangle_31.png",
          height: 289,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 40, // Adjust the top position to place the header correctly
          left: 15,
          child: Row(
            children: [
              SizedBox(
                height: 24, // Set the desired height
                width: 24, // Set the desired width
                child: IconButton(
                  padding: EdgeInsets.zero, // Remove default padding
                  iconSize: 24, // Adjust the icon size
                  onPressed: () {
                    //code to execute when this button is pressed
                  },
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
    );
  }

  /// Section Widget
  Widget _MyBuildViewSection(BuildContext context, List<Review> rewiews) {
    return ListView.builder(
        itemCount: rewiews.length,
        itemBuilder: (context, index) {
          Review review = rewiews[index];
          return  _MyBuildTextReview(review: '');
        }
    );


    // return Column(
    //   children: [
    //     _MyBuildTextReview(review: ''),
    //     _MyBuildImageRewiew(img: ''),
    //   ],
    // );
  }

  Widget _MyBuildTextReview({required String review}) {
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
                  child: Image.asset(
                    "assets/images/img_ellipse_62.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Anonymous",
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
          const SizedBox(height: 12),
          const Text(
            "That was such a nice place. The most beautiful place I’ve ever seen. My advice to everyone not to forget to take warm coat",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(0XFF141414),
              fontSize: 16,
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  Widget _MyBuildImageRewiew({required String img}) {
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
                  child: Image.asset(
                    "assets/images/img_ellipse_62.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Anonymous",
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
          const SizedBox(height: 12),
          Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                  width: 195,
                  height: 185,
                  "assets/images/img_rectangle_3.png")),
        ],
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
        onPressed: () =>
            const BookingModalSheet().show_booking_modal_sheet(context),
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

  /// Section Widget
  Widget _buildReviewText(BuildContext context) {
    return const Text(
      "That was such a nice place. The most beautiful place I’ve ever seen. My advice to everyone not to forget to take warm coat",
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Color(0XFF141414),
        fontSize: 16,
        fontFamily: 'SF Pro Display',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  /// Section Widget
  Widget _buildAnonymousReviewSection(BuildContext context) {
    return Expanded(
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
                  child: Image.asset(
                    "assets/images/img_ellipse_62.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Anonymous",
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
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.only(
              left: 12,
              right: 28,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Guilin, China",
                    style: TextStyle(
                      color: Color(0XFFFFFFFF),
                      fontSize: 14,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Image.asset(
                    "assets/images/img_rectangle_3.png",
                    height: 184,
                    width: 194,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 22),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 40,
              width: 184,
              decoration: const BoxDecoration(
                color: Color(0XFF9F9F9F),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildReviewText(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildViewRowSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 12,
      ),
      child: Row(
        children: [_buildAnonymousReviewSection(context)],
      ),
    );
  }
}
