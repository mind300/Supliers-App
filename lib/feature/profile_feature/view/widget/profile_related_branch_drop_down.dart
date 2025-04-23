import 'package:flutter/material.dart';

class ProfileRelatedBranchDropDown extends StatelessWidget {
  const ProfileRelatedBranchDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Related Branch',
        border: OutlineInputBorder(),
      ),
      items: [
        DropdownMenuItem(
          value: 'Branch 1',
          child: Text('Branch 1'),
        ),
        DropdownMenuItem(
          value: 'Branch 2',
          child: Text('Branch 2'),
        ),
        DropdownMenuItem(
          value: 'Branch 3',
          child: Text('Branch 3'),
        ),
      ],
      onChanged: (value) {
        // Handle the selected value
      },
    );
  }
}
