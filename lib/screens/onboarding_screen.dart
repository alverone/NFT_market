import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/models.dart';
import '../theme/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return const MaterialPage(
      name: "/onboarding",
      key: ValueKey("/onboarding"),
      child: OnboardingScreen(),
    );
  }

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomCenter,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/images/onboarding_background.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 33),
            constraints: const BoxConstraints.expand(height: 374),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: const WormEffect(
                    dotWidth: 7.62,
                    dotHeight: 7.62,
                    dotColor: Color(0xFFCFCFCF),
                    activeDotColor: AppColors.black,
                  ),
                ),
                const SizedBox(height: 41),
                Container(
                  constraints: const BoxConstraints.expand(
                    height: 140,
                    width: double.infinity,
                  ),
                  child: PageView(
                    clipBehavior: Clip.none,
                    padEnds: false,
                    controller: _pageController,
                    children: const [
                      _PageViewElement(
                        heading: 'Discover Rare\nCollectibles',
                        text: 'Buy and Sell Rare Collectibles from\n'
                            'Top Artists.',
                      ),
                      _PageViewElement(
                        heading: 'Heading',
                        text: 'Step 2',
                      ),
                      _PageViewElement(
                        heading: 'Heading',
                        text: 'Step 3',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 41),
                const _BottomButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//returns one page of PageView with set heading and text
class _PageViewElement extends StatelessWidget {
  final String heading;
  final String text;

  const _PageViewElement({
    Key? key,
    required this.heading,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(height: 140),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            heading,
            style: const TextStyle(
              fontSize: 28,
              height: 38 / 28,
              fontWeight: FontWeight.w800,
              color: AppColors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              height: 22 / 16,
              color: AppColors.black.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  const _BottomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28),
      alignment: Alignment.center,
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.main,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints.expand(),
            child: const Text(
              'Explore NFTs',
              style: TextStyle(
                fontSize: 20,
                height: 27 / 20,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          splashColor: Colors.white10,
          highlightColor: Colors.white10,
          onTap: () {
            Provider.of<AppStateManager>(context, listen: false)
                .completeOnboarding();
          },
        ),
      ),
    );
  }
}
