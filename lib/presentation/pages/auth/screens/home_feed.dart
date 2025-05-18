import 'dart:math';

import 'package:bloc_clean_arch/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key});

  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            color: Colors.black,

            height: 200,
            // width: 150,
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder:
                  (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(width: 100, color: Colors.red),
                  ),
            ),
          ),
        ),

        SliverList.builder(
          itemCount: 10,
          itemBuilder:
              (context, index) => SizedBox(
                height: 100,
                child: Card(color: Colors.deepPurpleAccent[index * 50]),
              ),
        ),
      ],
    );
  }
}
