import 'package:assignment/utils/color.dart';
import 'package:assignment/utils/routes.dart';
import 'package:assignment/widgets/sliding_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _indicatorController = PageController();
  final ScreenshotController screenshotController = ScreenshotController();
  final List<String> images = [
    'assets/images/image_car1.webp',
    'assets/images/image_car2.jpg',
    'assets/images/image_car3.webp'
  ];

  Future<void> _takeScreenshotAndShare() async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      final image = await screenshotController.capture();
      if (image == null) {
        if (kDebugMode) {
          print('Failed to capture screenshot');
        }
        return;
      }

      final directory = await getTemporaryDirectory();
      final imagePath = File('${directory.path}/screenshot.png');
      await imagePath.writeAsBytes(image);

      await Share.shareXFiles([XFile(imagePath.path)], text: 'Check out this Post!');
    } catch (e) {
      if (kDebugMode) {
        print('Error taking screenshot or sharing: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 350,
                            child: PageView(
                              controller: _indicatorController,
                              onPageChanged: (index) {
                                _indicatorController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 100),
                                  curve: Curves.linear,
                                );
                              },
                              children: images.map((image) {
                                return Image.asset(
                                  image,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                );
                              }).toList(),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: SizedBox(
                              height: 30,
                              width: MediaQuery.of(context).size.width / 1.05,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SmoothPageIndicator(
                                    controller: _indicatorController,
                                    count: images.length,
                                    effect: ExpandingDotsEffect(
                                      spacing: 3,
                                      dotHeight: 7,
                                      dotWidth: 7,
                                      activeDotColor: AppColors.primaryColor,
                                      dotColor: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Canyon road trip',
                                  style: GoogleFonts.inclusiveSans(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                IconButton(
                                  onPressed: _takeScreenshotAndShare,
                                  icon: Image.asset(
                                    'assets/icons/share-square.png',
                                    width: 25,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _buildInfoRow(
                                  iconPath: 'assets/icons/clock-five.png',
                                  title: 'Date and Time',
                                  subtitle: '3rd Feb, 24 - 6:00PM',
                                ),
                                const SizedBox(width: 25),
                                _buildInfoRow(
                                  iconPath: 'assets/icons/wallet-five.png',
                                  title: 'Cost',
                                  subtitle: '₹ 400',
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            _buildInfoRow(
                              iconPath: 'assets/icons/location.png',
                              title: 'Location',
                              subtitle: 'Denpasar - Jakarta',
                              isLocation: true,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                              style: GoogleFonts.inclusiveSans(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/user-five.png',
                                  width: 20,
                                  color: Colors.black54,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Hosts',
                                  style: GoogleFonts.inclusiveSans(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                for (var i = 1; i <= 4; i++)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/profile/user$i.png'),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: statusBarHeight + 50,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                      ),
                    ),
                  ),
                  Positioned(
                    top: statusBarHeight,
                    right: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              CupertinoIcons.back,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.more_horiz,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SlidingButton(onSlide: (){
              Navigator.pushNamed(context, Routes.successScreen);
            }),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String iconPath,
    required String title,
    required String subtitle,
    bool isLocation = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              iconPath,
              width: 20,
              color: Colors.black54,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: GoogleFonts.inclusiveSans(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              subtitle,
              style: GoogleFonts.inclusiveSans(
                fontSize: 17,
              ),
            ),
            if (isLocation) ...[
              const Icon(Icons.arrow_forward_rounded),
              Text(
                ' Jakarta',
                style: GoogleFonts.inclusiveSans(
                  fontSize: 17,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
