import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          CupertinoSearchTextField(
            controller: textController,
            padding: const EdgeInsets.all(10),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            suffixIcon: const Icon(
              Icons.cancel,
            ),
            style: TextStyle(
              color: Colors.white,
              backgroundColor: Colors.grey.withOpacity(0.3),
            ),
          )
        ],
      )),
    );
  }
}
