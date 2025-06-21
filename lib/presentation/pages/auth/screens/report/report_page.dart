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
  late final MediaBloc mediaBloc;

  String category = '';
  bool hasImagePresent = false;

  Future<void> _selectImage(bool showRemoveMediaActionbutton) async {
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
      showRemoveMediaActionbutton: showRemoveMediaActionbutton,
      onRemoveMediaSelected: () {
        Navigator.of(context).pop();
        context.read<MediaBloc>().add(MediaRemoveCurrentReportPictureEvent());
      },
    );
  }

  Future<void> _submitReport({required String category}) async {
    final currentState =
        context.read<MediaBloc>().state as MediaReportPictureSelected;
    final selectedImage = currentState.image.path;

    context.read<ReportSubmissionBloc>().add(
      ReportSubmissionSubmit(
        imagePath: selectedImage,
        category: category,
        description: _descriptionTextEditingController.text.trim(),
      ),
    );

    // clear description field
    _descriptionTextEditingController.clear();

    // remove sent image
    context.read<MediaBloc>().add(MediaRemoveCurrentReportPictureEvent());

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    mediaBloc = context.read<MediaBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionTextEditingController.dispose();
    mediaBloc.add(MediaRemoveCurrentReportPictureEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(Globals.reportPageTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                const SizedBox(height: 20),
                BlocBuilder<MediaBloc, MediaState>(
                  builder: (context, state) {
                    // no report image taken / selected
                    if (state is MediaNoReportPicturesSelectedState) {
                      hasImagePresent = false;
                      return _ReportImageContainer(
                        onTap: () => _selectImage(hasImagePresent),
                      );
                    }
                    // report image taken / selected
                    else {
                      final currentState = state as MediaReportPictureSelected;
                      final selectedImage = currentState.image.path;
                      hasImagePresent = true;
                      return GestureDetector(
                        onTap:
                            () => context.read<MediaBloc>().add(
                              MediaSelectImageFromGalleryEvent(),
                            ),
                        child: _ReportImageContainer(
                          onTap: () => _selectImage(hasImagePresent),
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
                        initialValue: Globals.reportCategoryItems[0],
                        hintText: Globals.reportCategoryDropDownLabel,
                        items: Globals.reportCategoryItems,
                        onChanged: (value) {
                          category = value!;
                        },
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
                    setState(() {});
                    if (!hasImagePresent) {
                      SnackbarDefinition.warningSnackbar(
                        context: context,
                        message: 'Insert a relevant image to your report',
                      );
                    }

                    if (_formKey.currentState!.validate() &&
                        hasImagePresent == true) {
                      CustomDialogBottomAppSheet.cupertinoAlertDialog(
                        context: context,
                        title: Globals.reportSubmissionAlertTitle,
                        content: Globals.reportSubmissionAlertContent,
                        onDestructiveActionPressed:
                            () => _submitReport(category: category),
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
                ? ClipRRect(
                  borderRadius: AppDimensions.circleBorderRadius,
                  child: Image.file(
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                    File(selectedImage!),
                  ),
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
