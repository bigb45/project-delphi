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
  late GoogleMapController _mapController;

  final Set<Polyline> polylines = {};
  final List<LatLng> _routePoints = const [
    LatLng(31.9053544601599, 35.20592818490456),
    LatLng(31.90601630175916, 35.20814644268508),
    LatLng(31.90662394678749, 35.21051777978334),
    LatLng(31.90667000554085, 35.21157203882197),
    LatLng(31.90659667014141, 35.21318475442082),
    LatLng(31.90713192778817, 35.21361267367403),
    LatLng(31.9109094268626, 35.21586435865929),
    LatLng(31.91151294353682, 35.21606243202883),
    LatLng(31.91637351319492, 35.21583541761113),
    LatLng(31.9180921416186, 35.21567682932381),
    LatLng(31.91874618980642, 35.2159396901732),
    LatLng(31.91951490307092, 35.21662069168706),
    LatLng(31.92004389080214, 35.21715907543499),
    LatLng(31.92082462523716, 35.21444133579557),
    LatLng(31.92168216893316, 35.21396200891462),
    LatLng(31.92476956985254, 35.2145125901326),
    LatLng(31.92624789550297, 35.21296136797481),
    LatLng(31.92637994951565, 35.21297032637945),
    LatLng(31.92648510165664, 35.21311150053212),
    LatLng(31.92642360331217, 35.21391099956971),
    LatLng(31.9264556665428, 35.21415407574364),
    LatLng(31.92674154245667, 35.21448477231523),
    LatLng(31.92789372958306, 35.21558396179001),
  ];

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
    _addRoute();
    _searchFocusNode.addListener(() {
      setState(() {
        isSeparated = !_searchFocusNode.hasFocus;
      });
      onSearchTap();
    });
  }

  void _addRoute() {
    final Polyline routePolyline = Polyline(
      polylineId: PolylineId('route_1'),
      points: _routePoints,
      color: Colors.blue,
      width: 5,
    );

    setState(() {
      polylines.add(routePolyline);
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
              initialCameraPosition: CameraPosition(
                target: _routePoints[0], // Focus on the first point
                zoom: 10,
              ),
              polylines: polylines,
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
