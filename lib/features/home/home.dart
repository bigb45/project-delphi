import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_delphi/gen/assets.gen.dart';
import 'package:project_delphi/widgets/button.dart' as custom;
import 'package:project_delphi/widgets/floating_searchbar.dart';
import 'package:project_delphi/widgets/floating_separable_topbar.dart';
import 'package:project_delphi/widgets/icon_button.dart';
import 'package:project_delphi/widgets/location_chip.dart';
import 'package:project_delphi/widgets/search_textfield.dart';

const Duration duration = Duration(milliseconds: 150);

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSeparated = false;
  Widget child = const Text("separated");
  Widget leadingIcon = const Icon(Icons.arrow_back);
  final TextEditingController _controller = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  int? selectedLocationCardIndex;
  final ScrollController _locationCardScrollController = ScrollController();
  late GoogleMapController _mapController;
  List<GlobalKey> itemKeys = List.generate(mockList.length, (_) => GlobalKey());
  List<int> itemWidths = [];
  int selectedCardOffset = 0;
  bool selectedCardCrossed = false;
  Set<Marker> _markersList = {};
  final CameraPosition initialCameraPosition = const CameraPosition(
      zoom: 14, target: LatLng(31.908988679315637, 35.20323287752521));
  // bool selectedCardCrossedEnd = false;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void updateSelectedCardState(bool hasCrossed) {
    if (selectedCardCrossed != hasCrossed) {
      setState(() {
        selectedCardCrossed = hasCrossed;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateItemWidths();
    });
    // pin card to the right side
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

    _searchFocusNode.addListener(() {
      setState(() {
        isSeparated = !_searchFocusNode.hasFocus;
      });
      onSearchTap();
    });
  }

  void _calculateItemWidths() {
    itemWidths = itemKeys
        .map((key) => key.currentContext!.findRenderObject() as RenderBox)
        .map((box) => box.size.width.toInt())
        .toList();
  }

  void onSearchTap() {
    if (!isSeparated) {
      _searchFocusNode.requestFocus();
    }
    setState(() {
      print("is separated: $isSeparated");
      child = !isSeparated
          ? SearchTextfield(
              controller: _controller,
              focusNode: _searchFocusNode,
              onTextChanged: (val) {
                print("new value: $val");
              })
          : SizedBox(
              width: double.infinity,
              child: Text(
                key: const ValueKey("select widget"),
                "Choose a starting Point",
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
              ),
            );
      leadingIcon = !isSeparated
          ? Icon(
              key: const ValueKey("arrow back icon"),
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.inversePrimary,
            )
          : Icon(
              key: const ValueKey("filter icon"),
              Icons.filter_list_sharp,
              color: Theme.of(context).colorScheme.inversePrimary,
            );
      isSeparated = !isSeparated;
    });
  }

  void calculateSelectedCardOffset(int index) {
    if (index > 0) {
      selectedCardOffset = itemWidths
          .getRange(0, index)
          .reduce((value, element) => value + element);
    }
  }

  void _addMarker(LatLng position) {
    final marker = Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      infoWindow: InfoWindow(
        title: "Custom Location",
        snippet: "${position.latitude}, ${position.longitude}",
      ),
    );

    setState(() {
      _markersList.clear();
      _markersList.add(marker);
    });
  }

  void _clearMarkers() {
    setState(() {
      _markersList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLocationCardSelected = selectedLocationCardIndex != null;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: FloatingSeparableTopbar(
          isSeparated: isSeparated,
          leadingIcon: leadingIcon,
          child: child,
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: initialCameraPosition,
              markers: _markersList,
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedSwitcher(
                  duration: duration,
                  child: isLocationCardSelected
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Row(
                            children: [
                              Expanded(
                                child: custom.Button(
                                  buttonStyle: custom.ButtonStyle.secondary,
                                  text: "Done",
                                  onPressed: () {
                                    /*TODO: move to next screen*/
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              CustomIconButton(
                                icon: Icons.search_rounded,
                                onPressed: () {
                                  onSearchTap();
                                },
                              )
                            ],
                          ),
                        )
                      : Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          visible: !isSeparated,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: isSeparated ? 0 : 1,
                            child: GestureDetector(
                                onTap: () {
                                  onSearchTap();
                                },
                                child: const FloatingSearchbar()),
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 5),
                          color: Theme.of(context)
                              .colorScheme
                              .inverseSurface
                              .withOpacity(0.1),
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
                                  isSelected:
                                      index == selectedLocationCardIndex,
                                  onTap: () {
                                    setState(() {
                                      selectedCardCrossed = false;
                                      if (selectedLocationCardIndex == index) {
                                        selectedLocationCardIndex = null;
                                        _clearMarkers();
                                      } else {
                                        selectedLocationCardIndex = index;
                                        calculateSelectedCardOffset(index);
                                        _addMarker(mockList[index].coords);
                                        _mapController.animateCamera(
                                          CameraUpdate.newLatLng(
                                            mockList[index].coords,
                                          ),
                                        );
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
                                    selectedLocationCardIndex =
                                        null; // Unpin selected chip
                                    _clearMarkers();
                                  });
                                },
                              ),
                            )
                          : const SizedBox(
                              key: ValueKey("empty location chip"),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ],
        ),
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
