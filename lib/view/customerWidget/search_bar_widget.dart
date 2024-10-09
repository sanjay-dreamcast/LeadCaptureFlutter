



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/strings.dart';

import '../../theme/app_theme.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch;

  const SearchBarWidget({super.key, required this.onSearch});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          print("obj_.>${value}");
          widget.onSearch(value);
          setState(() {});
        },
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 15, right: 6, top: 12, bottom: 12),
            child: Icon(
              Icons.search,
              color: Colors.grey,
              size: 30.0,
            ),
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.close),
            color: Colors.grey,
            onPressed: () {
              _searchController.clear();
              widget.onSearch(''); // Reset the search filter
              setState(() {}); // Rebuild to hide the clear button
            },
          )
              : null,
          hintText: MyStrings.search_here,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: "figtree",
          ),
          filled: true,
          fillColor: indicatorColor,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: AppBorderRadius.circular(),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}