import 'package:flutter/material.dart';
import 'package:project_delphi/gen/assets.gen.dart';
import 'package:project_delphi/widgets/floating_searchbar.dart';
import 'package:project_delphi/widgets/floating_topbar.dart';
import 'package:project_delphi/widgets/location_chip.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const FloatingTopbar(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.darkMap.path),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingSearchbar(),
              const SizedBox(height: 16),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(10, (index) {
                      return LocationChip(
                        text: mockList[index % mockList.length],
                        isFavorite: index.isEven,
                      );
                    })
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> mockList = [
  "Home",
  "Work",
  "Gym",
  "School",
  "Park",
  "Cafe",
  "Restaurant",
  "Bar",
  "Library",
];
