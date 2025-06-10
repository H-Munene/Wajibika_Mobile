import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/domain/repositories/user_repository.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/screens/home/week_highlights.dart';
import 'package:bloc_clean_arch/presentation/providers/user_provider.dart';
import 'package:bloc_clean_arch/presentation/widgets/custom_richtext.dart';
import 'package:bloc_clean_arch/presentation/widgets/wajibika_points_progress.dart';
import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/utils/app_assets.dart';
import 'package:provider/provider.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key});

  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> with TickerProviderStateMixin {
  int wajibikaPoints = 47;
  List<String> images = [AppImages.cleanup, AppImages.cleanup2, AppImages.team];

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final username = context.read<UserRepository>().getUserName().fold(
      (_) => 'user',
      (username) => username,
    );

    return Padding(
      padding: AppDimensions.pagePadding,
      child: NestedScrollView(
        headerSliverBuilder:
            (context, isInnerBoxScrolled) => [
              SliverToBoxAdapter(
                child: Column(
                  // spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRichText(
                      highlightColor: Colors.black,
                      regularText: 'Good Morning, ',
                      highlightedText: '$username☀️',
                    ),

                    WajibikaPointsProgress(wajibikaPoints: wajibikaPoints),
                    Text(
                      'Week highlights',
                      style: textTheme.titleMedium?.copyWith(fontSize: 20),
                    ),
                    const WeekHighlights(),
                  ],
                ),
              ),
              SliverAppBar(
                pinned: true,
                surfaceTintColor: Colors.white,
                primary: false,
                toolbarHeight: 0,
                backgroundColor: Colors.white,
                bottom: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Text(
                        'Clogged Drains',
                        style: textTheme.bodyMedium?.copyWith(fontSize: 13),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Negligent Dumping',
                        style: textTheme.bodyMedium?.copyWith(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.separated(
              itemBuilder:
                  (context, index) =>
                      Container(height: 100, width: 200, color: Colors.teal),
              separatorBuilder:
                  (context, index) => const Divider(indent: 10, endIndent: 10),
              itemCount: 10,
            ),
            ListView.separated(
              itemBuilder:
                  (context, index) =>
                      Container(height: 100, width: 200, color: Colors.green),
              separatorBuilder:
                  (context, index) => const Divider(indent: 10, endIndent: 10),
              itemCount: 10,
            ),
          ],
        ),
      ),
    );
  }
}
