import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_tour/data/repository/places_repository.dart';
import 'package:neo_tour/models/place.dart';
import 'package:neo_tour/models/tour.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';
import '../../models/review.dart';
import '../../ui/widgets/booking_modal_sheet.dart';

class PlaceScreen extends StatefulWidget {
  final Place singlePlace;

  const PlaceScreen({super.key, required this.singlePlace});

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  Tour? _detail;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTourDetail(widget.singlePlace.id.toString());
  }

  Future<void> _loadTourDetail(String id) async {
    try {
      Tour detail = await PlacesRepository().getPlaceDetail(id);
      setState(() {
        _detail = detail;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading tour details: $e');
    }
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
              child: _buildMountFujiSection(
                context,
                widget.singlePlace.name,
                _detail?.location ?? '',
                _isLoading,
              ),
            ),
            Positioned(
              top: 20,
              left: 15,
              child: Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 24,
                      onPressed: () => context.pop(),
                      icon: Image.asset('assets/icons/back_button.png'),
                    ),
                  ),
                  const SizedBox(width: 5),
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

  Widget _buildMountFujiSection(BuildContext context, String name, String location, bool loading) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 250),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0XFFFFFFFF),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                color: Color(0XFF141414),
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  height: 14,
                  width: 14,
                  child: Image.asset("assets/icons/location.png"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    location.isNotEmpty ? location : "Unknown location",
                    style: const TextStyle(
                      color: Color(0XFF141414),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Description",
              style: TextStyle(
                color: Color(0XFF141414),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _detail?.description ?? 'No description available.',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0XFF141414),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              "Reviews",
              style: TextStyle(
                color: Color(0XFF141414),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildReviewSection(),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewSection() {
    if (_detail == null || _detail!.reviews.isEmpty) {
      return const Text(
        'No reviews available.',
        style: TextStyle(
          color: Color(0XFF141414),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      );
    }

    return Column(
      children: _detail!.reviews.map((review) => _buildReviewItem(review)).toList(),
    );
  }

  Widget _buildReviewItem(Review review) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/img_ellipse_62.png",
                  height: 24,
                  width: 24,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  "Anonymous",
                  style: TextStyle(
                    color: Color(0XFF141414),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.review,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0XFF141414),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookNowButton(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0XFF6A62B6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        ),
        onPressed: () => const BookingModalSheet().show_booking_modal_sheet(context),
        child: const Text(
          "Book Now",
          style: TextStyle(
            color: Color(0XFFFFFFFF),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
