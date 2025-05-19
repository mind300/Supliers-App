import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/core/components/custom_text_form_field.dart';
import 'package:supplies/core/components/loading.dart';
import 'package:supplies/core/components/retry_widget.dart';
import 'package:supplies/core/components/toast_manager.dart';
import 'package:supplies/core/helpers/custom_image_handler.dart';
import 'package:supplies/feature/add_offer_feature/controller/add_offer_cubit.dart';
import 'package:supplies/feature/add_offer_feature/view/widget/add_offer_drop_down.dart';

class AddOfferScreen extends StatelessWidget {
  const AddOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddOfferCubit, AddOfferState>(
      buildWhen: (previous, current) => current is AddOfferCategoriesLoaded || current is AddOfferCategoryError || current is AddOfferCategoriesLoading,
      listener: (context, state) {
        if (state is AddOfferLoading) {
          startLoading(context);
        }
        if (state is AddOfferError) {
          stopLoading(context);
          ToastManager.showErrorToast(state.message);
        }
        if (state is AddOfferSuccess) {
          stopLoading(context);
          Navigator.of(context).pop(true);
          ToastManager.showToast(state.message);
        }
        if (state is AddOfferWarning) {
          ToastManager.showErrorToast(state.message);
        }

        // if (state is AddOfferSuccess) {
        //   Navigator.pop(context);
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text('Offer added successfully'),
        //       backgroundColor: Colors.green,
        //     ),
        //   );
        // }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add Offer'),
          ),
          body: state is AddOfferCategoryError
              ? RetryWidget(
                  onRetry: () {
                    context.read<AddOfferCubit>().getCategores();
                  },
                  message: state.message,
                )
              : state is AddOfferCategoriesLoaded
                  ? state.categoriesList.content!.isEmpty
                      ? Center(
                          child: Text(
                            'No branches available to add an offer',
                            style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                          ),
                        )
                      : SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                          child: Form(
                            key: context.read<AddOfferCubit>().formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: BlocBuilder<AddOfferCubit, AddOfferState>(
                                    buildWhen: (_, state) => state is AddOfferImagePicked,
                                    builder: (context, state) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: SizedBox(
                                          height: 170.h,
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () => context.read<AddOfferCubit>().pickMultipleImages(),
                                                child: Container(
                                                  margin: EdgeInsets.all(0.sp),
                                                  width: 150.sp,
                                                  height: 150.sp,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius: BorderRadius.circular(10.r),
                                                  ),
                                                  child: Icon(
                                                    Icons.add_a_photo,
                                                    size: 50.sp,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              if (context.read<AddOfferCubit>().selectedImages != null && context.read<AddOfferCubit>().selectedImages!.isNotEmpty)
                                                ...List.generate(
                                                  context.read<AddOfferCubit>().selectedImages!.length,
                                                  (index) => GestureDetector(
                                                    onTap: () {
                                                      context.read<AddOfferCubit>().removeImage(index);
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child: AddOfferImage(
                                                        image: context.read<AddOfferCubit>().selectedImages![index],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                CustomTextFormField(
                                  hintText: 'Title',
                                  title: "Title",
                                  controller: context.read<AddOfferCubit>().offerNameController,
                                  textInputType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a title';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.h),
                                CustomTextFormField(
                                  hintText: 'Description',
                                  title: "Description",
                                  controller: context.read<AddOfferCubit>().offerDescriptionController,
                                  textInputType: TextInputType.text,
                                  maxLines: 5,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a description';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.h),
                                //discount
                                CustomTextFormField(
                                  hintText: 'Discount',
                                  title: "Discount",
                                  controller: context.read<AddOfferCubit>().offerDiscountController,
                                  textInputType: TextInputType.number,
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.all(12.sp),
                                    child: Text(
                                      '%',
                                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a discount';
                                    }
                                    if (double.tryParse(value) == null || double.parse(value) < 0 || double.parse(value) > 100) {
                                      return 'Please enter a valid discount percentage';
                                    }

                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.h),
                                BlocBuilder<AddOfferCubit, AddOfferState>(
                                  buildWhen: (previous, current) => current is AddOfferCategoriesLoaded || current is AddOfferCategoryChanged,
                                  builder: (context, s) {
                                    return AddOfferDropDown(
                                      title: "Select Branch",
                                      selectedItems: context.read<AddOfferCubit>().selectedCategories,
                                      items: state.categoriesList.content!.map((e) => DropDownModel.fromJson(e.toJson())).toList(),
                                      onChanged: (List<DropDownModel> selectedItems) {
                                        context.read<AddOfferCubit>().onCategoryChanged(selectedItems);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: CustomButton(
              onPressed: () {
                context.read<AddOfferCubit>().addOffer();
              },
              text: 'Add Offer',
            ),
          ),
        );
      },
    );
  }
}

class AddOfferImage extends StatelessWidget {
  const AddOfferImage({
    super.key,
    required this.image,
  });
  final dynamic image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomImageHandler(
          path: image,
          width: 150.sp,
          height: 150.sp,
          fit: BoxFit.cover,
        ),
        Icon(
          Icons.delete,
          color: Colors.red,
          size: 50.sp,
        ),
      ],
    );
  }
}
