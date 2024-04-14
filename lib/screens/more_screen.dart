import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => NewAndHotScreen();
}

class NewAndHotScreen extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'New & Hot',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.black,
            actions: [
              const Icon(
                Icons.cast,
                color: Colors.white,
              ),
              const SizedBox(
                width: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  height: 27,
                  width: 27,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
            bottom: TabBar(
                isScrollable: false,
                dividerColor: Colors.black,
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                unselectedLabelColor: Colors.white,
                tabs: [
                  Tab(
                    text: 'Comming Soon',
                  ),
                  Tab(
                    text: "Everyone's Watching",
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
