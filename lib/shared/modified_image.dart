import 'package:flutter/material.dart';

ImageProvider<Object> modifiedImageNetwork(String url) {
  if (url == null || url == '') return AssetImage("assets/images/transparent.png");
  return NetworkImage(url);
}
ImageProvider<Object> modifiedPostImageNetwork(String url) {
  if (url == null || url == '') return AssetImage("assets/images/transparent_post.png");
  return NetworkImage(url);
}

