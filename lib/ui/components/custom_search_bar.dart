import 'package:flutter/material.dart';
import 'package:pokedex/core/resources/themes.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.controller,
    this.onSubmitted,
    this.onCleared,
  });

  final TextEditingController controller;
  final Function(String)? onSubmitted;
  final Function()? onCleared;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: widget.onSubmitted,
      controller: widget.controller,
      style: textTheme(context).bodyMedium,
      decoration: InputDecoration(
        hintText: "Find The Pokemon",
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        prefixIcon: widget.controller.text.isEmpty
            ? Icon(Icons.search, size: 20)
            : IconButton(
                onPressed: () {
                  widget.controller.clear();
                  widget.onCleared;
                },
                icon: Icon(Icons.clear, size: 20),
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
    );
  }
}
