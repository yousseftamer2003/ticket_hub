import 'package:flutter/material.dart';

Widget customAppBar(BuildContext context,String title) {
  return AppBar(
    title: Text(title),
    leading: IconButton(
    onPressed: (){
      Navigator.of(context).pop();
    }, 
    icon: const Icon(Icons.arrow_back_ios)),
  );
}