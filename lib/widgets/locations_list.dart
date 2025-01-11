import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_delphi/widgets/location_chip.dart';

class LocationsList extends StatefulWidget {
  final Function(int) onCardSelectedCallback;
  final VoidCallback onCardUnselectedCallback;
  const LocationsList(
      {super.key,
      required this.onCardSelectedCallback,
      required this.onCardUnselectedCallback});

  @override
  State<LocationsList> createState() => LocationsListState();
}

class LocationsListState extends State<LocationsList> {
  final ScrollController _locationCardScrollController = ScrollController();

  int? selectedLocationCardIndex;

  int selectedCardOffset = 0;
  bool selectedCardCrossed = false;

  List<GlobalKey> itemKeys = List.generate(mockList.length, (_) => GlobalKey());
  List<int> itemWidths = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateItemWidths();
    });
    _locationCardScrollController.addListener(() {
      // pin card to the left side
      if (selectedLocationCardIndex != null &&
          selectedLocationCardIndex! > 0 &&
          _locationCardScrollController.offset > selectedCardOffset) {
        updateSelectedCardState(true);
      }
      // if the first card is selected
      else if (selectedLocationCardIndex != null &&
          selectedLocationCardIndex == 0) {
        updateSelectedCardState(true);
      } else {
        updateSelectedCardState(false);
      }
    });
  }

  void updateSelectedCardState(bool hasCrossed) {
    if (selectedCardCrossed != hasCrossed) {
      setState(() {
        selectedCardCrossed = hasCrossed;
      });
    }
  }

  void calculateSelectedCardOffset(int index) {
    if (index > 0) {
      selectedCardOffset = itemWidths
          .getRange(0, index)
          .reduce((value, element) => value + element);
    }
  }

  void _calculateItemWidths() {
    itemWidths = itemKeys
        .map((key) => key.currentContext!.findRenderObject() as RenderBox)
        .map((box) => box.size.width.toInt())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    bool isLocationCardSelected = selectedLocationCardIndex != null;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 5),
              color:
                  Theme.of(context).colorScheme.inverseSurface.withOpacity(0.1),
              blurRadius: 16,
              spreadRadius: 8)
        ],
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: _locationCardScrollController,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  ...List.generate(mockList.length, (index) {
                    if (selectedCardCrossed &&
                        selectedLocationCardIndex == index) {
                      return SizedBox(
                        width: itemWidths[index].toDouble(),
                      );
                    }
                    return LocationChip(
                      key: itemKeys[index],
                      text: mockList[index].name,
                      isFavorite: index.isEven,
                      isSelected: index == selectedLocationCardIndex,
                      onTap: () {
                        setState(() {
                          selectedCardCrossed = false;
                          if (selectedLocationCardIndex == index) {
                            selectedLocationCardIndex = null;
                            // _clearMarkers();
                            widget.onCardUnselectedCallback();
                          } else {
                            selectedLocationCardIndex = index;
                            calculateSelectedCardOffset(index);
                            widget.onCardSelectedCallback.call(index);
                            // _addMarker(mockList[index].coords);
                            // _mapController.animateCamera(
                            //   CameraUpdate.newLatLng(
                            //     mockList[index].coords,
                            //   ),
                            // );
                          }
                        });
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
          isLocationCardSelected && selectedCardCrossed
              ? Positioned(
                  left: 32,
                  child: LocationChip(
                    key: const ValueKey("selected location card"),
                    text: mockList[selectedLocationCardIndex!].name,
                    isFavorite: selectedLocationCardIndex!.isEven,
                    isSelected: true,
                    onTap: () {
                      setState(() {
                        selectedLocationCardIndex = null; // Unpin selected chip
                        // _clearMarkers();
                        widget.onCardUnselectedCallback();
                      });
                    },
                  ),
                )
              : const SizedBox(
                  key: ValueKey("empty location chip"),
                ),
        ],
      ),
    );
  }
}

List<Location> mockList = [
  const Location(
      name: "Home",
      coords: const LatLng(
        31.905632,
        35.204874,
      ),
      isFavorite: true),
  const Location(
    name: "Work",
    coords: LatLng(
      31.910254,
      35.202134,
    ),
  ),
  const Location(
      name: "Gym",
      coords: LatLng(
        31.912774,
        35.207893,
      ),
      isFavorite: true),
  const Location(
    name: "School",
    coords: LatLng(
      31.901374,
      35.209456,
    ),
  ),
  const Location(
    name: "Park",
    coords: LatLng(
      31.903981,
      35.206742,
    ),
  ),
  const Location(
    name: "Cafe",
    coords: LatLng(
      31.907124,
      35.205118,
    ),
  ),
  const Location(
    name: "Restaurant",
    coords: LatLng(
      31.908712,
      35.208956,
    ),
  ),
  const Location(
    name: "Bar",
    coords: LatLng(
      31.906543,
      35.201732,
    ),
  ),
  const Location(
      name: "Library",
      coords: LatLng(
        31.909371,
        35.203598,
      ),
      isFavorite: true),
];

class Location {
  final String name;
  final LatLng coords;
  final bool isFavorite;
  const Location(
      {required this.name, required this.coords, this.isFavorite = false});
}
