import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:neo_tour/big_app_text.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  List images = [
    "mountain4.jpeg",
    "mountain8.jpeg",
    "mountain9.jpeg",
  ];
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 5, vsync: this);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    Tab(text: 'Evrope'),
                    Tab(text: 'Asia'),
                  ]),
            ),
            Container(
              width: double.maxFinite,
              height: 250,
              child: TabBarView(controller: _tabController, children: [
                Scrollbar(
                  thickness: 8.0,
                  //trackVisibility: true,
                  thumbVisibility: true,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Image.asset('assets/images/img_rectangle_3.png'),
                      Image.asset('assets/images/img_rectangle_3.png'),
                      Image.asset('assets/images/img_rectangle_3.png'),
                      Image.asset('assets/images/img_rectangle_3.png'),
                    ],
                  ),
                ),
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 300,
                      height: 150, 
                      margin: EdgeInsets.all(8.0), // Add some margin for better spacing
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                            'assets/images/img_rectangle_3.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                Text('data'),
                Container(),
                Container(),
              ]),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                padding: const EdgeInsets.only(left: 10),
                child: BigAppText(text: "Recommended", size: 20)),
          ],
        ),
      ),
    );
  }
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
