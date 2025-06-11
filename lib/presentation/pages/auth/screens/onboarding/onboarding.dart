import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/core/utils/app_assets.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/pages.dart';
import 'package:bloc_clean_arch/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();

  bool onLastPage = false;
  late List<String> images;
  @override
  void initState() {
    images = [AppImages.neighbourhood, AppImages.report, AppImages.volunteer];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: SizedBox(
          height: 0.92 * MediaQuery.of(context).size.height,
          child: PageView(
            onPageChanged:
                (index) => setState(() {
                  onLastPage = (index == 2);
                }),
            controller: _pageController,
            children: [
              OnboardPageLayout(
                imageUrl: images[0],
                textTheme: textTheme,
                title: 'Your Neighborhood, Your Voice',
                content:
                    'See a clogged drain causing flooding? Spot illegal dumping in your area? Your reports help local authorities prioritize what needs fixing first',
              ),
              OnboardPageLayout(
                imageUrl: images[1],
                textTheme: textTheme,
                title: 'Simple Reporting Process',
                content:
                    'Just snap a photo or pick one from your gallery, add a description, select the category, and submit. Make a difference in under 1 minute.',
              ),
              OnboardPageLayout(
                imageUrl: images[2],
                textTheme: textTheme,
                title: 'Community Action',
                content:
                    'Join volunteer cleanup events organized by your neighbors, or become a community lead to spearhead environmental action.',
              ),
            ],
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: 0.08 * MediaQuery.of(context).size.height,
        child: Padding(
          padding: AppDimensions.pagePadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                onDotClicked:
                    (index) => _pageController.animateToPage(
                      index,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                    ),

                effect: const SlideEffect(
                  spacing: 10,
                  radius: 0,
                  dotWidth: 24,
                  dotHeight: 10,
                  paintStyle: PaintingStyle.stroke,
                  strokeWidth: 1.5,
                  dotColor: AppColors.unselectedItemColor,
                  activeDotColor: AppColors.primaryColor,
                ),
              ),

              CustomButtonWidget(
                color: Colors.white,
                makeButtonRounded: true,
                onPressed:
                    () =>
                        onLastPage
                            ? Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => const LoginPage(),
                                transitionDuration: Duration.zero,
                              ),
                            )
                            : _pageController.nextPage(
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut,
                            ),
                child: Text(
                  onLastPage ? 'Get Started' : 'Next',
                  style: textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardPageLayout extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String content;

  const OnboardPageLayout({
    super.key,
    required this.textTheme,
    required this.imageUrl,
    required this.title,
    required this.content,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset(imageUrl, fit: BoxFit.cover).image,
        ),
      ),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title, style: textTheme.titleSmall),

          Text(content),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
