import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'custom_shimmer.dart';

class CustomImage extends StatelessWidget {
  final String? url;
  final double? width, height;
  final BorderRadius? borderRadius;
  final BoxFit? fit;
  final String? errorAssets;
  final BoxShape? boxShape;

  const CustomImage({
    super.key,
    @required this.url,
    this.width,
    this.height,
    this.borderRadius,
    this.errorAssets,
    this.fit = BoxFit.cover,
    this.boxShape,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: boxShape != null
            ? null
            : (borderRadius ?? BorderRadius.circular(0.0)),
        shape: boxShape ?? BoxShape.rectangle,
      ),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          CachedNetworkImage(
            fit: fit!,
            imageUrl: url!,
            placeholder: (context, string) => Container(
              alignment: Alignment.center,
              child: ShimmeringObject(
                radius: borderRadius ?? BorderRadius.circular(50),
              ),
            ),
            errorWidget: (context, string, obj) {
              if (errorAssets == null) {
                return Center(child: Icon(Icons.error_outline));
              }
              return Image.asset(errorAssets!, fit: BoxFit.cover);
            },
          ),
        ],
      ),
    );
  }
}
