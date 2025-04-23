import 'package:flutter/material.dart';
import 'package:supplies/core/components/custom_floating_action_button.dart';
import 'package:supplies/core/constant/app_images.dart';
import 'package:supplies/core/widgets/drawer.dart';

class BranchScreen extends StatelessWidget {
  const BranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // final canAdd = args?['canAdd'] ?? false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Branches'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text(
          'Welcome to the Branch Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        icon: AppImages.add,
        onPressed: () {
          print('Floating Action Button Pressed');
        },
      ),
    );
  }
}
