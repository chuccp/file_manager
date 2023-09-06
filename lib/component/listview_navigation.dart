import 'package:flutter/material.dart';

class ListviewWithNavigation extends StatefulWidget {
  const ListviewWithNavigation({super.key, required this.destinations, this.onSelected, this.selectedIndex, required this.builder});



  final List<NavigationRailDestination> destinations;

  final ValueChanged<int>? onSelected;

  final int? selectedIndex;

  final WidgetBuilder builder;

  @override
  State<StatefulWidget> createState() => _ListviewWithNavigationState();
}

class _ListviewWithNavigationState extends State<ListviewWithNavigation> {


  @override
  Widget build(BuildContext context) {

    return Container(
        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
        child: Ink(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 120,
                  child: NavigationRail(
                    labelType: NavigationRailLabelType.all,
                    destinations: widget.destinations,
                    selectedIndex: widget.selectedIndex,
                    onDestinationSelected: widget.onSelected,
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: widget.builder,
                  ),
                ),
              ],
            )));
  }
}
