import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplies/core/components/custom_button.dart';
import 'package:supplies/feature/branch_details_feature/controller/branch_details_cubit.dart';

class EditButtonWidget extends StatelessWidget {
  const EditButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchDetailsCubit, BranchDetailsState>(
      buildWhen: (previous, current) => current is BranchDetailsEditUpdated,
      builder: (context, state) {
        bool isEditing = context.read<BranchDetailsCubit>().isEditing;
        // Animation of the action buttons
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: !isEditing
              ? SizedBox()
              : CustomButton(
                  onPressed: () {
                    context.read<BranchDetailsCubit>().updateBranchDetails();
                  },
                  text: "Edit",
                ),
        );
      },
    );
  }
}
