import 'dart:io';

import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/bloc/media/bloc/media_bloc.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ListView(
      children: [
        // TODO: insert images for carousel
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: screenHeight / 4),
          child: CarouselView(
            itemExtent: 0.8 * screenWidth,
            children: List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsetsDirectional.all(8),
                child: Container(color: const Color(0xFF760000)),
              ),
            ),
          ),
        ),
        const Divider(),
        // user feed
        //tabs : pending, volunteer, completed,
        //pending, ->
        // have
        // volunteer -> has , *
        //
        // completed

        //tab
        // image with di
        //
      ],
    );
  }
}
