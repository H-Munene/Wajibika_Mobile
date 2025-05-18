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
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: BlocConsumer<MediaBloc, MediaState>(
            listener: (context, state) {
              if (state is MediaPictureSelectionFailed) {
                SnackbarDefinition.errorSnackBar(
                  context: context,
                  message: 'Failed to select images',
                );
              }
            },
            builder: (context, state) {
              if (state is MediaPicturesSelectedFromGallery) {
                return SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.images.length,
                    itemBuilder:
                        (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.file(
                            width: 300,
                            fit: BoxFit.cover,
                            File(state.images[index].path),
                          ),
                        ),
                  ),
                );
              } else {
                return const Text(
                  'No pictures selected',
                  textAlign: TextAlign.center,
                );
              }
            },
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
