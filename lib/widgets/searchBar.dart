import 'package:flutter/material.dart';
import 'package:scaneat/res/colors.dart';
import 'package:scaneat/utils/helper.dart';

class SearchBar extends StatelessWidget {
  String title;
  SearchBar(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            size: 28,
            color: Colors.orange.shade200,
          ),
          hintText: title,
          hintStyle: TextStyle(
            color: AppColor.placeholder,
            fontSize: 18,
          ),
          contentPadding: const EdgeInsets.only(
            top: 12,
          ),
        ),
      ),
    );
  }
}
