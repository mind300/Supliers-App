import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/loading.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/core/constant/app_colors.dart';
import 'package:supplies/core/helpers/extensitions.dart';
import 'package:supplies/core/routes/routes.dart';
import 'package:supplies/feature/add_offer_feature/controller/add_offer_cubit.dart';
import 'package:supplies/feature/offer_details_feature/view/screen/offer_details.dart';
import 'package:supplies/feature/offer_feature/data/model/offer_model/content.dart';

class OfferDetailsScreen extends StatelessWidget {
  const OfferDetailsScreen({super.key, required this.offer});
  final Content offer;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddOfferCubit, AddOfferState>(
      listener: (context, state) {
        if (state is AddOfferDeleteLoading) {
          startLoading(context);
        } else if (state is AddOfferDeleteSuccess) {
          stopLoading(context);
          Navigator.of(context).pop(true);
        } else if (state is AddOfferDeleteError) {
          stopLoading(context);
          ToastManager.showErrorToast(state.message);
        }
      },
      builder: (context, state) {
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
                        context.read<AddOfferCubit>().deleteOffer(offer.id!);
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
      },
    );
  }
}
