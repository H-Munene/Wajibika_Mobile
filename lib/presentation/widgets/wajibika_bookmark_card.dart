import 'package:bloc_clean_arch/core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WajibikaBookmarkCard extends StatelessWidget {
  final String imageUrl;
  final String description;
  final void Function() onBookmarkIconPressed;

  const WajibikaBookmarkCard({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.onBookmarkIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        height: 150,
        child: Row(
          children: [
            ClipRRect(
              child: Image.network(
                imageUrl,
                height: 150,
                width: 150,
                cacheHeight: 150,
                cacheWidth: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                spacing: 7,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     const Icon(CupertinoIcons.photo_camera),
                  //     Text(
                  //       '  |  ${reportCategory == Globals.reportCategoryItems[0] ? 'Clogged Drain' : 'Negligent Dumping'}',
                  //       style: const TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    width: 210,
                    child: Text(
                      description,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 170, top: 35),
                    child: IconButton(
                      onPressed: onBookmarkIconPressed,
                      icon: const Icon(CupertinoIcons.bookmark_fill),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
