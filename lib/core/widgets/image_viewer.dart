import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';

class ImageViewer extends StatelessWidget {
  ImageViewer({super.key, required this.images});
  final List<String> images;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Viewer'),
      ),
      body: Row(
        children: [
          IconButton(
            onPressed: () {
              if (pageController.page == 0) {
                return;
              }
              pageController.previousPage(duration: Duration(microseconds: 300), curve: Curves.bounceIn);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primary,
              size: 30.sp,
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Center(
                    child: CustomImageHandler(
                      path: images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          IconButton(
            onPressed: () {
              if (pageController.page == images.length - 1) {
                return;
              }
              pageController.nextPage(duration: Duration(microseconds: 300), curve: Curves.easeInOutQuad);
            },
            icon: Icon(
              Icons.arrow_forward_ios_outlined,
              color: AppColors.primary,
              size: 30.sp,
            ),
          ),
        ],
      ),
    );
  }
}
