import 'package:flutter/material.dart';
import 'package:pokedex/core/resources/themes.dart';
import 'package:pokedex/core/utils/extension.dart';

class PokemonTypeDropdown extends StatefulWidget {
  const PokemonTypeDropdown({super.key, required this.onTypeSelected});

  final Function(List<String>) onTypeSelected;

  @override
  State<PokemonTypeDropdown> createState() => _PokemonTypeDropdownState();
}

class _PokemonTypeDropdownState extends State<PokemonTypeDropdown> {
  final List<String> types = pokemonTypes;
  List<String> selectedTypes = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: GestureDetector(
        onTap: () {
          _openTypeSelector();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    selectedTypes.isEmpty
                        ? "All Type"
                        : selectedTypes.join(", "),
                    overflow: TextOverflow.ellipsis,
                    style: textTheme(context).titleMedium?.copyWith(
                      color: colorScheme(context).surface,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: colorScheme(context).surface,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openTypeSelector() async {
    final result = await showDialog<List<String>>(
      context: context,
      builder: (txt) {
        final tempSelected = List<String>.from(selectedTypes);
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Choose Pokemon Types"),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: pokemonTypes.map((type) {
                    return CheckboxListTile(
                      title: Text(type),
                      value: tempSelected.contains(type),
                      onChanged: (checked) {
                        setDialogState(() {
                          if (checked == true) {
                            tempSelected.add(type);
                          } else {
                            tempSelected.remove(type);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                tempSelected.isEmpty
                    ? TextButton(
                        onPressed: () => Navigator.pop(txt, null),
                        child: Text("Cancel"),
                      )
                    : TextButton(
                        onPressed: () {
                          setDialogState(() {
                            tempSelected.clear();
                          });
                        },
                        child: const Text("Reset"),
                      ),
                TextButton(
                  onPressed: () => Navigator.pop(txt, tempSelected),
                  child: Text("Done"),
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedTypes = result;
      });
      widget.onTypeSelected(selectedTypes);
    }
  }
}
