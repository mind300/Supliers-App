import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageHandler extends StatelessWidget {
  const CustomImageHandler({
    super.key,
    required this.path,
    this.fit = BoxFit.contain,
    this.height,
    this.width,
    this.size,
    this.color,
  });
  final dynamic path;
  final BoxFit fit;
  final double? height, width, size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (path == null) {
      return Icon(
        Icons.error,
        size: width ?? size ?? 24,
        color: Colors.red,
      );
    }
    if (path is IconData) {
      return Icon(
        path,
        color: color,
        size: size,
      );
    }
    if (path is File) {
      return Image.file(
        path,
        fit: fit,
        color: color,
        height: height,
        width: width,
      );
    }
    if (path is Uint8List) {
      return Image.memory(
        path,
        fit: fit,
        color: color,
        height: height,
        width: width,
      );
    }
    if (path.endsWith('.svg')) {
      return SizedBox(
        height: height,
        width: width,
        child: SvgPicture.asset(
          path,
          fit: fit,
          height: height,
          width: width,
          colorFilter: color == null
              ? null
              : ColorFilter.mode(
                  color!,
                  BlendMode.srcIn,
                ),
        ),
      );
    }
    if (path.startsWith('http') ||
        path.startsWith('https') ||
        path.startsWith('www.')) {
      return CachedNetworkImage(
        imageUrl: path,
        fit: fit,
        width: width,
        height: height,
        errorWidget: (BuildContext context, _, stackTrace) {
          return const Center(
            child: Icon(Icons.error),
          );
        },
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return Center(
            child: SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
              ),
            ),
          );
        },
      );
    }

    return Image.asset(
      path,
      fit: fit,
      color: color,
      height: height,
      width: width,
    );
  }
}
