import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_delphi/gen/assets.gen.dart';
import 'package:project_delphi/widgets/button.dart' as custom;
import 'package:project_delphi/widgets/floating_searchbar.dart';
import 'package:project_delphi/widgets/floating_separable_topbar.dart';
import 'package:project_delphi/widgets/icon_button.dart';
import 'package:project_delphi/widgets/location_chip.dart';
import 'package:project_delphi/widgets/locations_list.dart';
import 'package:project_delphi/widgets/search_textfield.dart';

const Duration duration = Duration(milliseconds: 150);

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSeparated = false;
  Widget child = const Text("Choose a starting Point");
  Widget leadingIcon = const Icon(Icons.filter_list);

  final TextEditingController _controller = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  // final ScrollController _locationCardScrollController = ScrollController();
  late GoogleMapController _mapController;

  int? selectedLocationCardIndex;

  int selectedCardOffset = 0;
  bool selectedCardCrossed = false;

  Set<Marker> _markersList = {};
  final CameraPosition initialCameraPosition = const CameraPosition(
      zoom: 14, target: LatLng(31.908988679315637, 35.20323287752521));

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        isSeparated = !_searchFocusNode.hasFocus;
      });
      onSearchTap();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    child = SizedBox(
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

    leadingIcon = Icon(
      key: const ValueKey("filter icon"),
      Icons.filter_list_sharp,
      color: Theme.of(context).colorScheme.inversePrimary,
    );
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
          onTopbarClicked: !isSeparated ? onSearchTap : null,
          onSeparatedIconClicked: !isSeparated
              ? null
              : () {
                  setState(() {
                    _searchFocusNode.unfocus();
                    isSeparated = !isSeparated;
                  });
                },
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
                LocationsList(
                  onCardSelectedCallback: (index) {
                    _addMarker(mockList[index].coords);
                    _mapController.animateCamera(
                      CameraUpdate.newLatLng(
                        mockList[index].coords,
                      ),
                    );
                  },
                  onCardUnselectedCallback: () {
                    _clearMarkers();
                  },
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
