import 'package:flutter/material.dart';
import 'package:advanced_weather_app/models/location_model.dart';
import 'package:advanced_weather_app/services/location_service.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController searchText;
  final VoidCallback onLocationPressed;
  final Function(Location) onSearchPressed;

  const TopBar({
    super.key,
    required this.searchText,
    required this.onLocationPressed,
    required this.onSearchPressed,
  });

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10.0);
}

class _TopBarState extends State<TopBar> {
  List<Location> suggestions = [];
  final _searchController = SearchController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchCities(String query, BuildContext context) async {
    final locationService = context.read<LocationService>();
    final cities = await locationService.searchCities(query);
    setState(() => suggestions = cities.sublist(0, 5));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20.0),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: SearchAnchor(
                searchController: _searchController,
                viewConstraints: const BoxConstraints(maxHeight: 300),
                isFullScreen: true,
                viewLeading: const Icon(Icons.search),
                viewHintText: 'Search city',
                builder: (context, searchAnchorController) {
                  return SearchBar(
                    leading: const Icon(Icons.search),
                    hintText: 'Search city',
                    controller: widget.searchText,
                    onChanged: (value) {
                      searchAnchorController.text = value;
                    },
                    onTap: () {
                      searchAnchorController.text = widget.searchText.text;
                      searchAnchorController.openView();
                    },
                  );
                },
                viewOnSubmitted: (value) {
                  if (value.isNotEmpty) {
                    if (suggestions.isNotEmpty) {
                      final city = suggestions.first;
                      widget.searchText.text = '';
                      print('Selected by Enter: $city');
                      widget.onSearchPressed(city);
                    } else {
                      final locationService = context.read<LocationService>();
                      locationService.setError(
                        'No cities found matching "$value"',
                      );
                    }
                  }
                  _searchController.closeView('');

                },
                suggestionsBuilder: (context, searchController) async {
                  if (searchController.text.isEmpty) {
                    return const [
                      ListTile(title: Text('Start typing to search cities...')),
                    ];
                  }

                  await _searchCities(searchController.text, context);

                  if (suggestions.isEmpty) {
                    return const [ListTile(title: Text('No cities found'))];
                  }

                  return suggestions
                      .map(
                        (city) => ListTile(
                          title: Text(city.city ?? ''),
                          subtitle: Text(
                            '${city.region ?? ''}, ${city.country ?? ''}',
                          ),
                          onTap: () {
                            searchController.closeView('');
                            FocusScope.of(context).unfocus();
                            widget.searchText.text = '';
                            widget.onSearchPressed(city);
                          },
                        ),
                      )
                      .toList();
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.location_on),
              onPressed: widget.onLocationPressed,
            ),
          ],
        ),
      ),
    );
  }
}
