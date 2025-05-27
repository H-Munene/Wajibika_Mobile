import 'dart:io';

import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/bloc/report_media/media_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap:
                    () => context.read<MediaBloc>().add(
                      MediaSelectImageFromGalleryEvent(),
                    ),
                child: BlocBuilder<MediaBloc, MediaState>(
                  builder: (context, state) {
                    if (state is MediaNoReportPicturesSelectedState) {
                      return GestureDetector(
                        onTap:
                            () => context.read<MediaBloc>().add(
                              MediaSelectImageFromGalleryEvent(),
                            ),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: AppDimensions.circleBorderRadius,
                            border: Border.all(),
                          ),
                          child: const Column(
                            children: [
                              SizedBox(height: 100),
                              Text('Select Image'),
                              Icon(Icons.folder, size: 34),
                            ],
                          ),
                        ),
                      );
                    } else {
                      final currentState =
                          state as MediaReportPictureSelected;
                      final selectedImage = currentState.image.path;
                      return GestureDetector(
                        onTap:
                            () => context.read<MediaBloc>().add(
                              MediaSelectImageFromGalleryEvent(),
                            ),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(border: Border.all()),
                          child: Image.file(
                            height: 300,
                            width: 300,
                            fit: BoxFit.cover,
                            File(selectedImage),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
