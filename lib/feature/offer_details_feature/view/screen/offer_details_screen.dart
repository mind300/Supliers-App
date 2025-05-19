import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/feature/offer_details_feature/view/screen/offer_details.dart';
import 'package:supplies/feature/offer_details_feature/view/widget/offer_expansion_tile.dart';
import 'package:supplies/feature/offer_feature/data/model/offer_model/content.dart';

class OfferDetailsScreen extends StatelessWidget {
  const OfferDetailsScreen({super.key, required this.offer});
  final Content offer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offer Details'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text('Edit'),
                  onTap: () {
                    // context.read<ProfileCubit>().toggleEditing();\
                    context.pushReplacementNamed(
                      Routes.addOffer,
                      arguments: offer,
                    );
                  },
                ),
                PopupMenuItem(
                  child: Text('Delete'),
                  onTap: () {
                    // Handle delete action
                    // context.read<ProfileCubit>().deleteProfile();
                  },
                ),
              ];
            },
            icon: Icon(Icons.more_vert, color: AppColors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: OfferDetails(
          offer: offer,
        ),
      ),
    );
  }
}
