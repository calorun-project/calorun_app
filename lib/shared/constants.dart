import 'package:flutter/material.dart';

final loadIcon = CircularProgressIndicator(
  valueColor: AlwaysStoppedAnimation(Colors.black),
);

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff297373), width: 2.0),
  ),
);
