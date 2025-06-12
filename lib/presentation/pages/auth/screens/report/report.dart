import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final TextEditingController _descriptionTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String category = '';

  Future<void> _selectImage() async {
    CustomDialogBottomAppSheet.mediaSelectionBottomSheet(
      context: context,
      onCameraSelected: () {
        Navigator.of(context).pop();
        context.read<MediaBloc>().add(MediaTakePictureWithCameraEvent());
      },
      onGallerySelected: () {
        Navigator.of(context).pop();
        context.read<MediaBloc>().add(MediaSelectImageFromGalleryEvent());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(Globals.reportPageTitle),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              BlocBuilder<MediaBloc, MediaState>(
                builder: (context, state) {
                  // no report image taken / selected
                  if (state is MediaNoReportPicturesSelectedState) {
                    return _ReportImageContainer(onTap: _selectImage);
                  }
                  // report image taken / selected
                  else {
                    final currentState = state as MediaReportPictureSelected;
                    final selectedImage = currentState.image.path;
                    return GestureDetector(
                      onTap:
                          () => context.read<MediaBloc>().add(
                            MediaSelectImageFromGalleryEvent(),
                          ),
                      child: _ReportImageContainer(
                        onTap: _selectImage,
                        selectedImage: selectedImage,
                      ),
                    );
                  }
                },
              ),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomDropDown(
                      hintText: Globals.reportCategoryDropDownLabel,
                      items: Globals.reportCategoryItems,
                      onChanged: (value) => category = value!,
                    ),

                    CustomTextFieldFormWidget(
                      hasMaxLines: true,
                      hintText: Globals.reportDescriptionHint,
                      label: Globals.reportDescriptionTextFieldLabel,
                      prefixIcon: CupertinoIcons.pen,
                      controller: _descriptionTextEditingController,
                      validator: FormValidation.descriptionValidator,
                    ),
                  ],
                ),
              ),

              CustomButtonWidget(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    CustomDialogBottomAppSheet.cupertinoAlertDialog(
                      context: context,
                      title: Globals.reportSubmissionAlertTitle,
                      content: Globals.reportSubmissionAlertContent,
                      onDestructiveActionPressed: () {
                        print('Category: $category');
                        print(
                          'Description: ${_descriptionTextEditingController.text}',
                        );
                        Navigator.of(context).pop();
                      },
                    );
                  }
                },
                child: Text(
                  'Submit',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportImageContainer extends StatelessWidget {
  const _ReportImageContainer({this.selectedImage, required this.onTap});

  final String? selectedImage;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          border: Border.all(),

          borderRadius:
              selectedImage != null
                  ? AppDimensions.circleBorderRadius
                  : AppDimensions.unfocussedCircleBorderRadius,
        ),
        child:
            selectedImage != null
                ? Image.file(
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                  File(selectedImage!),
                )
                : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Select Image'),
                    Icon(Icons.folder, size: 34),
                  ],
                ),
      ),
    );
  }
}
