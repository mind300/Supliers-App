

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerBox({
  required double height,
  required double width,
  double radius = 8.0,
}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.blueAccent.shade100,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
  );
}