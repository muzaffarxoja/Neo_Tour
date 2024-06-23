import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:neo_tour/big_app_text.dart';
import 'package:neo_tour/data/repository/places_repository.dart';
import 'package:neo_tour/models/place.dart';

import '../../main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  List<Place> _places = [];
  bool _isLoading = true;
  List<Place> _popular = [];
  List<Place> _featured = [];
  List<Place> _most_visited = [];
  List<Place> _europe = [];
  List<Place> _asia = [];
  List<Place> _recomended = [];

  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }

  void _loadPlaces() async {
    List<Place> places = await PlacesRepository().getPlaceList();
    setState(() {
      _places = places;
      _isLoading = false;

      //Initialize places for each section
      List<Place> popular =
          List<Place>.generate(4, (int index) => _places[index]);
      _popular = popular;
      List<Place> featured =
          List<Place>.generate(5, (int index) => _places[index + 4]);
      _featured = featured;
      List<Place> most_visited =
          List<Place>.generate(1, (int index) => _places[index + 9]);
      _most_visited = most_visited;
      List<Place> asia =
          List<Place>.generate(1, (int index) => _places[index + 10]);
      _asia = asia;
      List<Place> europe =
          List<Place>.generate(1, (int index) => _places[index + 11]);
      _europe = europe;

      List<Place> recomended =
          List<Place>.generate(4, (int index) => _places[index + 5]);
      _recomended = recomended;
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 5, vsync: this);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
                padding: const EdgeInsets.only(left: 10),
                child: const BigAppText(text: "Discover", size: 30)),
            // const SizedBox(
            //   height: 30,
            // ),
            Container(
              child: TabBar(
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.only(left: 20, right: 0),
                  isScrollable: true,
                  indicator:
                      CircleTabIndicator(color: Color(0xff6A62B7), radius: 5),
                  controller: _tabController,
                  tabs: [
                    Tab(text: 'Popular'),
                    Tab(text: 'Featured'),
                    Tab(text: 'Most viited'),
                    Tab(text: 'Europe'),
                    Tab(text: 'Asia'),
                  ]),
            ),
            Container(
              width: double.maxFinite,
              height: 250,
              child: TabBarView(controller: _tabController, children: [
                _buildDynamicImageListView(_popular, _isLoading),
                _buildDynamicImageListView(_featured, _isLoading),
                _buildDynamicImageListView(_most_visited, _isLoading),
                _buildDynamicImageListView(_europe, _isLoading),
                _buildDynamicImageListView(_asia, _isLoading),
              ]),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                padding: const EdgeInsets.only(left: 10),
                child: BigAppText(text: "Recommended", size: 20)),

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: _recomended.length,
                itemBuilder: (context, index) {
                  Place place = _recomended[index];
                  return Container(
                    width: 150,
                    height: 100,
                    margin: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GestureDetector(
                        child: Image.network(
                          place.image, // Assuming Place has an imageUrl property
                          fit: BoxFit.cover,
                        ),
                        onTap: () => context.push(place_screen, extra: place),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildDynamicImageListView(List<Place> section_places, bool loading) {
  if (loading) {
    return const Center(child: CircularProgressIndicator());
  }

  if (section_places.isEmpty) {
    return const Center(child: Text('No places available'));
  }

  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: section_places.length,
    itemBuilder: (context, index) {
      Place place = section_places[index];
      return Container(
        width: 300,
        height: 150,
        margin: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GestureDetector(
            child: Image.network(
              place.image, // Assuming Place has an imageUrl property
              fit: BoxFit.cover,
            ),
            onTap: () => context.push(place_screen, extra: place),
          ),
        ),
      );
    },
  );
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

// Container(
//   padding: const EdgeInsets.only(
//     left: 20,
//     top: 70,
//   ),
//   child: Row(
//     children: [
//       Icon(Icons.menu, size: 30, color: Colors.black54),
//       Expanded(child: Container()),
//       Container(
//         width: 30,
//         height: 30,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Colors.grey[500],
//         ),
//       ),
//       SizedBox(
//         width: 20,
//       )
//     ],
//   ),
// ),

// ListView(
//   scrollDirection: Axis.horizontal,
//   children: [
//     Image.asset('assets/images/img_rectangle_3.png'),
//     Image.asset('assets/images/img_rectangle_3.png'),
//     Image.asset('assets/images/img_rectangle_3.png'),
//     Image.asset('assets/images/img_rectangle_3.png'),
//   ],
// ),
// ListView.builder(
//   scrollDirection: Axis.horizontal,
//   itemCount: 5,
//   itemBuilder: (context, index) {
//     return Container(
//       width: 300,
//       height: 150,
//       margin: EdgeInsets.all(8.0), // Add some margin for better spacing
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Image.asset(
//             'assets/images/img_rectangle_3.png',
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   },
// ),
// ListView.builder(
//   scrollDirection: Axis.horizontal,
//   itemCount: 5,
//   itemBuilder: (context, index) {
//     return Container(
//       width: 300,
//       height: 150,
//       margin: EdgeInsets.all(8.0), // Add some margin for better spacing
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Image.asset(
//           'assets/images/img_rectangle_3.png',
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   },
// ),
// Container(),
// Container(),
