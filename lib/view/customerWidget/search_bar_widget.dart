



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/strings.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch; // Callback for search functionality

  const SearchBarWidget({super.key, required this.onSearch});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          print("obj_.>${value}");
          widget.onSearch(value);
          setState(() {});
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
            size: 35.0,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.close),
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
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: "figtree_medium",
          ),
          filled: true,
          fillColor: indicatorColor,
          contentPadding: EdgeInsets.all(0.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}