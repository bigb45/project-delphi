import 'package:flutter/material.dart';
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

  List<GlobalKey> itemKeys = List.generate(mockList.length, (_) => GlobalKey());
  List<int> itemWidths = [];
  int selectedCardOffset = 0;
  bool selectedCardCrossed = false;
  // bool selectedCardCrossedEnd = false;
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
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.mapLight.path),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
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
                                onPressed: () {/*TODO: move to next screen*/},
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
                                text: mockList[index],
                                isFavorite: index.isEven,
                                isSelected: index == selectedLocationCardIndex,
                                onTap: () {
                                  setState(() {
                                    selectedCardCrossed = false;
                                    if (selectedLocationCardIndex == index) {
                                      selectedLocationCardIndex = null;
                                    } else {
                                      selectedLocationCardIndex = index;
                                      calculateSelectedCardOffset(index);
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
                              text: mockList[selectedLocationCardIndex!],
                              isFavorite: selectedLocationCardIndex!.isEven,
                              isSelected: true,
                              onTap: () {
                                setState(() {
                                  selectedLocationCardIndex =
                                      null; // Unpin logic
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
