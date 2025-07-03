/*
<!--
       
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
 
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */

import 'package:disstrikt/app/export.dart';


enum MultiSelectListType { LIST, CHIP }

class MultiSelectDialog<T> extends StatefulWidget
    implements MultiSelectActions<T> {
  /// List of items to select from.
  final List<MultiSelectItem<T>> items;

  /// The list of selected values before interaction.
  final List<T> initialValue;

  /// The text at the top of the dialog.
  final Widget? title;

  /// Fires when the an item is selected / unselected.
  final void Function(List<T>)? onSelectionChanged;

  /// Fires when confirm is tapped.
  final void Function(List<T>)? onConfirm;

  /// Toggles search functionality. Default is false.
  final bool searchable;

  /// Text on the confirm button.
  final Text? confirmText;

  /// Text on the cancel button.
  final Text? cancelText;

  /// An enum that determines which type of list to render.
  final MultiSelectListType? listType;

  /// Sets the color of the checkbox or chip when it's selected.
  final Color? selectedColor;

  /// Sets a fixed height on the dialog.
  final double? height;

  /// Sets a fixed width on the dialog.
  final double? width;

  /// Set the placeholder text of the search field.
  final String? searchHint;

  /// A function that sets the color of selected items based on their value.
  /// It will either set the chip color, or the checkbox color depending on the list type.
  final Color? Function(T)? colorator;

  /// The background color of the dialog.
  final Color? backgroundColor;

  /// The color of the chip body or checkbox border while not selected.
  final Color? unselectedColor;

  /// Icon button that shows the search field.
  final Icon? searchIcon;

  /// Icon button that hides the search field
  final Icon? closeSearchIcon;

  /// Style the text on the chips or list tiles.
  final TextStyle? itemsTextStyle;

  /// Style the text on the selected chips or list tiles.
  final TextStyle? selectedItemsTextStyle;

  /// Style the search text.
  final TextStyle? searchTextStyle;

  /// Style the search hint.
  final TextStyle? searchHintStyle;

  /// Moves the selected items to the top of the list.
  final bool separateSelectedItems;

  /// Set the color of the check in the checkbox
  final Color? checkColor;

  const MultiSelectDialog({super.key, 
    required this.items,
    required this.initialValue,
    this.title,
    this.onSelectionChanged,
    this.onConfirm,
    this.listType,
    this.searchable = false,
    this.confirmText,
    this.cancelText,
    this.selectedColor,
    this.searchHint,
    this.height,
    this.width,
    this.colorator,
    this.backgroundColor,
    this.unselectedColor,
    this.searchIcon,
    this.closeSearchIcon,
    this.itemsTextStyle,
    this.searchHintStyle,
    this.searchTextStyle,
    this.selectedItemsTextStyle,
    this.separateSelectedItems = false,
    this.checkColor,
  });

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<T>(items);

  @override
  void onCancelTap(BuildContext ctx, List<T> initiallySelectedValues) {
    // TODO: implement onCancelTap
  }

  @override
  void onConfirmTap(
      BuildContext ctx, List<T> selectedValues, Function(List<T>)? onConfirm) {
    Navigator.pop(ctx, selectedValues);
    if (onConfirm != null) {
      onConfirm(selectedValues);
    }
  }

  @override
  List<T> onItemCheckedChange(
      List<T> selectedValues, T itemValue, bool checked) {
    if (checked) {
      selectedValues.add(itemValue);
    } else {
      selectedValues.remove(itemValue);
    }
    return selectedValues;
  }

  @override
  bool onSearchTap(bool showSearch) {
    // TODO: implement onSearchTap
    throw UnimplementedError();
  }

  @override
  List<MultiSelectItem<T>> separateSelected(List<MultiSelectItem<T>> list) {
    // TODO: implement separateSelected
    throw UnimplementedError();
  }

  @override
  List<MultiSelectItem<T>> updateSearchQuery(
      String? val, List<MultiSelectItem<T>> allItems) {
    // TODO: implement updateSearchQuery
    throw UnimplementedError();
  }
}

class _MultiSelectDialogState<T> extends State<MultiSelectDialog<T>> {
  List<T> _selectedValues = [];
  bool _showSearch = false;
  List<MultiSelectItem<T>> _items;

  _MultiSelectDialogState(this._items);

  @override
  void initState() {
    super.initState();
    _selectedValues.addAll(widget.initialValue);

    for (int i = 0; i < _items.length; i++) {
      _items[i].selected = false;
      if (_selectedValues.contains(_items[i].value)) {
        _items[i].selected = true;
      }
    }

    if (widget.separateSelectedItems) {
      _items = widget.separateSelected(_items);
    }
  }

  /// Returns a CheckboxListTile
  Widget _buildListItem(MultiSelectItem<T> item) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: widget.unselectedColor ?? Colors.black54,
      ),
      child: CheckboxListTile(
        contentPadding:
            EdgeInsets.symmetric(vertical: 0, horizontal: margin_15),
        visualDensity: const VisualDensity(vertical: -4),
        checkboxShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius_3)),
        checkColor: widget.checkColor,
        value: item.selected,
        activeColor: widget.colorator != null
            ? widget.colorator!(item.value) ?? widget.selectedColor
            : widget.selectedColor,
        title: Text(
          item.label,
          style: item.selected
              ? widget.selectedItemsTextStyle
              : widget.itemsTextStyle,
        ),
        controlAffinity: ListTileControlAffinity.trailing,
        onChanged: (checked) {
          setState(() {
            _selectedValues = widget.onItemCheckedChange(
                _selectedValues, item.value, checked!);

            if (checked) {
              item.selected = true;
            } else {
              item.selected = false;
            }
            if (widget.separateSelectedItems) {
              _items = widget.separateSelected(_items);
            }
          });
          if (widget.onSelectionChanged != null) {
            widget.onSelectionChanged!(_selectedValues);
          }
        },
      ),
    );
  }

  /// Returns a ChoiceChip
  Widget _buildChipItem(MultiSelectItem<T> item) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: ChoiceChip(
        backgroundColor: widget.unselectedColor,
        selectedColor: widget.colorator?.call(item.value) ??
            widget.selectedColor ??
            Theme.of(context).primaryColor.withOpacity(0.35),
        label: Text(
          item.label,
          style: item.selected
              ? TextStyle(
                  color: widget.selectedItemsTextStyle?.color ??
                      widget.colorator?.call(item.value) ??
                      widget.selectedColor?.withOpacity(1) ??
                      Theme.of(context).primaryColor,
                  fontSize: widget.selectedItemsTextStyle?.fontSize,
                )
              : widget.itemsTextStyle,
        ),
        selected: item.selected,
        onSelected: (checked) {
          if (checked) {
            item.selected = true;
          } else {
            item.selected = false;
          }
          setState(() {
            _selectedValues = widget.onItemCheckedChange(
                _selectedValues, item.value, checked);
          });
          if (widget.onSelectionChanged != null) {
            widget.onSelectionChanged!(_selectedValues);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius_15)),
      buttonPadding:
          EdgeInsets.symmetric(vertical: margin_0, horizontal: margin_10),
      title: widget.searchable == false
          ? widget.title ?? const Text("strSelect")
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _showSearch
                    ? Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            style: widget.searchTextStyle,
                            decoration: InputDecoration(
                              hintStyle: widget.searchHintStyle,
                              hintText: widget.searchHint ?? "strSearch",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: widget.selectedColor ??
                                      Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            onChanged: (val) {
                              List<MultiSelectItem<T>> filteredList = [];
                              filteredList =
                                  widget.updateSearchQuery(val, widget.items);
                              setState(() {
                                if (widget.separateSelectedItems) {
                                  _items =
                                      widget.separateSelected(filteredList);
                                } else {
                                  _items = filteredList;
                                }
                              });
                            },
                          ),
                        ),
                      )
                    : widget.title ?? const Text("strSelect"),
                IconButton(
                  icon: _showSearch
                      ? widget.closeSearchIcon ?? const Icon(Icons.close)
                      : widget.searchIcon ?? const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _showSearch = !_showSearch;
                      if (!_showSearch) {
                        if (widget.separateSelectedItems) {
                          _items = widget.separateSelected(widget.items);
                        } else {
                          _items = widget.items;
                        }
                      }
                    });
                  },
                ),
              ],
            ),
      contentPadding:
          widget.listType == null || widget.listType == MultiSelectListType.LIST
              ? const EdgeInsets.only(top: 0.0)
              : const EdgeInsets.all(20),
      content: SizedBox(
        height: widget.height,
        width: widget.width ?? MediaQuery.of(context).size.width * 0.73,
        child: widget.listType == null ||
                widget.listType == MultiSelectListType.LIST
            ? ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return _buildListItem(_items[index]);
                },
              )
            : SingleChildScrollView(
                child: Wrap(
                  children: _items.map(_buildChipItem).toList(),
                ),
              ),
      ),
      actions: <Widget>[
        TextButton(
          child: widget.confirmText ??
              Text(
                "strOk",
                style: TextStyle(
                  color: (widget.selectedColor != null &&
                          widget.selectedColor != Colors.transparent)
                      ? widget.selectedColor!.withOpacity(1)
                      : Theme.of(context).primaryColor,
                ),
              ),
          onPressed: () {
            widget.onConfirmTap(context, _selectedValues, widget.onConfirm);
          },
        )
      ],
    );
  }
}

class MultiSelectActions<T> {
  List<T> onItemCheckedChange(
      List<T> selectedValues, T itemValue, bool checked) {
    if (checked) {
      selectedValues.add(itemValue);
    } else {
      selectedValues.remove(itemValue);
    }
    return selectedValues;
  }

  /// Pops the dialog from the navigation stack and returns the initially selected values.
  void onCancelTap(BuildContext ctx, List<T> initiallySelectedValues) {
    Navigator.pop(ctx, initiallySelectedValues);
  }

  /// Pops the dialog from the navigation stack and returns the selected values.
  /// Calls the onConfirm function if one was provided.
  void onConfirmTap(
      BuildContext ctx, List<T> selectedValues, Function(List<T>)? onConfirm) {
    Navigator.pop(ctx, selectedValues);
    if (onConfirm != null) {
      onConfirm(selectedValues);
    }
  }

  /// Accepts the search query, and the original list of items.
  /// If the search query is valid, return a filtered list, otherwise return the original list.
  List<MultiSelectItem<T>> updateSearchQuery(
      String? val, List<MultiSelectItem<T>> allItems) {
    if (val != null && val.trim().isNotEmpty) {
      List<MultiSelectItem<T>> filteredItems = [];
      for (var item in allItems) {
        if (item.label.toLowerCase().contains(val.toLowerCase())) {
          filteredItems.add(item);
        }
      }
      return filteredItems;
    } else {
      return allItems;
    }
  }

  /// Toggles the search field.
  bool onSearchTap(bool showSearch) {
    return !showSearch;
  }

  List<MultiSelectItem<T>> separateSelected(List<MultiSelectItem<T>> list) {
    List<MultiSelectItem<T>> selectedItems = [];
    List<MultiSelectItem<T>> nonSelectedItems = [];

    nonSelectedItems.addAll(list.where((element) => !element.selected));
    nonSelectedItems.sort((a, b) => a.label.compareTo(b.label));
    selectedItems.addAll(list.where((element) => element.selected));
    selectedItems.sort((a, b) => a.label.compareTo(b.label));

    return [...selectedItems, ...nonSelectedItems];
  }
}

class MultiSelectItem<T> {
  final T value;
  final String label;
  bool selected = false;

  MultiSelectItem(
    this.value,
    this.label,
  );
}
