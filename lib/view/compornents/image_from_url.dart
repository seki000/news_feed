import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageFromUrl extends StatelessWidget {
  final String? imageUrl;

  const ImageFromUrl({Key? key,this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isInvalidUrl = (imageUrl != null) ? imageUrl!.startsWith("http") : false; //画像のURLがHTTP出ないときの処理、たまにあるHTTPでないものは排除する
    if(imageUrl == null || imageUrl == "" || !isInvalidUrl){
      return const Icon(Icons.broken_image);
    }
    return CachedNetworkImage(
           imageUrl: imageUrl!,
               placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.broken_image),
      fit: BoxFit.cover,
    );
  }
}
