import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';

typedef OnOptionSelected<T> = void Function(List<ValueItem<T>> selectedOptions);

class UikMulti<T> extends StatefulWidget {
  final SelectionType selectionType;
  final String hint;
  final Color? hintColor;
  final double? hintFontSize;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? hintPadding;

  // Options
  final List<ValueItem<T>> options;
  final List<ValueItem<T>> selectedOptions;
  final List<ValueItem<T>> disabledOptions;
  final OnOptionSelected<T>? onOptionSelected;

  final void Function(int index, ValueItem<T> option)? onOptionRemoved;

  final Icon? selectedOptionIcon;
  final Color? selectedOptionTextColor;
  final Color? selectedOptionBackgroundColor;
  final Widget Function(BuildContext, ValueItem<T>)? selectedItemBuilder;

  final bool showChipInSingleSelectMode;
  final ChipConfig chipConfig;

  final Color? optionsBackgroundColor;
  final TextStyle? optionTextStyle;
  final double dropdownHeight;
  final Widget? optionSeparator;
  final bool alwaysShowOptionIcon;

  final Widget Function(BuildContext ctx, ValueItem<T> item, bool selected)?
      optionBuilder;

  final Color? fieldBackgroundColor;
  final Widget suffixIcon;
  final bool animateSuffixIcon;
  final Icon? clearIcon;
  final double height;
  final Decoration? inputDecoration;
  final double? borderRadius;
  final BorderRadiusGeometry? radiusGeometry;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double? borderWidth;
  final double? focusedBorderWidth;
  final EdgeInsets? padding;

  final TextStyle? singleSelectItemStyle;

  final int? maxItems;

  final Color? dropdownBackgroundColor;
  final Color? searchBackgroundColor;
  final double? dropdownBorderRadius;
  final double? dropdownMargin;
  final MultiSelectController<T>? controller;
  final bool searchEnabled;
  final String? searchLabel;

  const UikMulti(
      {Key? key,
      required this.onOptionSelected,
      required this.options,
      this.onOptionRemoved,
      this.selectedOptionTextColor,
      this.chipConfig = const ChipConfig(),
      this.selectionType = SelectionType.multi,
      this.hint = 'Select',
      this.hintColor = Colors.grey,
      this.hintFontSize = 14.0,
      this.height = 64,
      this.hintPadding = HintText.hintPaddingDefault,
      this.selectedOptions = const [],
      this.disabledOptions = const [],
      this.alwaysShowOptionIcon = false,
      this.optionTextStyle,
      this.selectedOptionIcon = const Icon(Icons.check),
      this.selectedOptionBackgroundColor,
      this.optionsBackgroundColor,
      this.fieldBackgroundColor = Colors.white,
      this.dropdownHeight = 200,
      this.showChipInSingleSelectMode = false,
      this.suffixIcon = const Icon(Icons.arrow_drop_down),
      this.clearIcon = const Icon(Icons.close_outlined, size: 20),
      this.selectedItemBuilder,
      this.optionSeparator,
      this.inputDecoration,
      this.hintStyle,
      this.padding,
      this.focusedBorderColor = Colors.black54,
      this.borderColor = Colors.grey,
      this.borderWidth = 0.4,
      this.focusedBorderWidth = 0.4,
      this.borderRadius = 12.0,
      this.radiusGeometry,
      this.maxItems,
      this.controller,
      this.searchEnabled = false,
      this.dropdownBorderRadius,
      this.dropdownMargin,
      this.dropdownBackgroundColor,
      this.searchBackgroundColor,
      this.animateSuffixIcon = true,
      this.singleSelectItemStyle,
      this.optionBuilder,
      this.searchLabel = 'Search'})
      : super(key: key);

  @override
  State<UikMulti<T>> createState() => _UikMultiState<T>();
}

class _UikMultiState<T> extends State<UikMulti<T>> {
  /// Options list that is used to display the options.
  final List<ValueItem<T>> _options = [];

  /// Selected options list that is used to display the selected options.
  final List<ValueItem<T>> _selectedOptions = [];

  /// Disabled options list that is used to display the disabled options.
  final List<ValueItem<T>> _disabledOptions = [];

  /// The controller for the dropdown.
  OverlayState? _overlayState;
  OverlayEntry? _overlayEntry;
  bool _selectionMode = false;

  late final FocusNode _focusNode;

  /// value notifier that is used for controller.
  late MultiSelectController<T> _controller;

  /// search field focus node
  FocusNode? _searchFocusNode;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
    _focusNode = FocusNode();
    _controller = widget.controller ?? MultiSelectController<T>();
  }

  /// Initializes the options, selected options and disabled options.
  /// If the options are fetched from the network, then the network call is made.
  /// If the options are passed as a parameter, then the options are initialized.
  void _initialize() async {
    if (!mounted) return;

    _options.addAll(_controller.options.isNotEmpty == true
        ? _controller.options
        : widget.options);

    _addOptions();
  }

  /// Adds the selected options and disabled options to the options list.
  void _addOptions() {
    setState(() {
      _selectedOptions.addAll(_controller.selectedOptions.isNotEmpty == true
          ? _controller.selectedOptions
          : widget.selectedOptions);
      _disabledOptions.addAll(_controller.disabledOptions.isNotEmpty == true
          ? _controller.disabledOptions
          : widget.disabledOptions);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller._isDisposed == false) {
        _controller.setOptions(_options);
        _controller.setSelectedOptions(_selectedOptions);
        _controller.setDisabledOptions(_disabledOptions);

        _controller.addListener(_handleControllerChange);
      }
    });
  }

  /// Handles the focus change to show/hide the dropdown.
  void _handleFocusChange() async {
    // await Future.delayed(Duration(seconds: 3));
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return buildOverlayEntry();
      },
    );
    _updateSelection();
    return;
  }

  void _updateSelection() {
    setState(() {
      _selectionMode =
          _focusNode.hasFocus || _searchFocusNode?.hasFocus == true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: null,
      splashFactory: null,
      onTap: _handleFocusChange,
      child: Container(
        height: _anyItemSelected ? null : widget.height,
        width: double.maxFinite,
        padding: _getContainerPadding(),
        decoration: _getContainerDecoration(),
        alignment: Alignment.centerLeft,
        child: _getContainerContent(),
      ),
    );
  }

  Widget _getContainerContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 5,
              child: HintText(
                hintText: widget.hint,
                hintColor: widget.hintColor,
                hintStyle: widget.hintStyle,
                hintPadding: widget.hintPadding,
              ),
            ),
            _buildSuffixIcon(),
          ],
        ),
        (_anyItemSelected)
            ? (widget.selectionType == SelectionType.single &&
                    !widget.showChipInSingleSelectMode)
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SingleSelectedItem(
                        label: _selectedOptions.first.label,
                        style: widget.singleSelectItemStyle),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: _buildSelectedItems(),
                  )
            : Container()
      ],
    );
  }

  Widget _buildSuffixIcon() {
    if (widget.animateSuffixIcon) {
      return AnimatedRotation(
        turns: _selectionMode ? 0.5 : 0,
        duration: const Duration(milliseconds: 300),
        child: widget.suffixIcon,
      );
    }
    return widget.suffixIcon;
  }

  /// return true if any item is selected.
  bool get _anyItemSelected => _selectedOptions.isNotEmpty;

  /// Container decoration for the dropdown.
  Decoration _getContainerDecoration() {
    return widget.inputDecoration ??
        BoxDecoration(
          color: widget.fieldBackgroundColor ?? Colors.white,
          borderRadius: widget.radiusGeometry ??
              BorderRadius.circular(widget.borderRadius ?? 12.0),
          border: _selectionMode
              ? Border.all(
                  color: widget.focusedBorderColor ?? Colors.grey,
                  width: widget.focusedBorderWidth ?? 0.4,
                )
              : Border.all(
                  color: widget.borderColor ?? Colors.grey,
                  width: widget.borderWidth ?? 0.4,
                ),
        );
  }

  /// Dispose the focus node and overlay entry.
  @override
  void dispose() {
    if (_overlayEntry?.mounted == true) {
      if (_overlayState != null && _overlayEntry != null) {
        _overlayEntry?.remove();
      }
      _overlayEntry = null;
      _overlayState?.dispose();
    }
    _focusNode.removeListener(_handleFocusChange);
    _searchFocusNode?.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _searchFocusNode?.dispose();
    _controller.removeListener(_handleControllerChange);

    if (widget.controller == null || widget.controller?.isDisposed == true) {
      _controller.dispose();
    }

    super.dispose();
  }

  /// Build the selected items for the dropdown.
  Widget _buildSelectedItems() {
    if (widget.chipConfig.wrapType == WrapType.scroll) {
      return ListView.separated(
        separatorBuilder: (context, index) =>
            _getChipSeparator(widget.chipConfig),
        scrollDirection: Axis.horizontal,
        itemCount: _selectedOptions.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final option = _selectedOptions[index];
          if (widget.selectedItemBuilder != null) {
            return widget.selectedItemBuilder!(context, option);
          }
          return _buildChip(option, widget.chipConfig);
        },
      );
    }
    return Wrap(
        spacing: widget.chipConfig.spacing,
        runSpacing: widget.chipConfig.runSpacing,
        children: mapIndexed(_selectedOptions, (index, item) {
          if (widget.selectedItemBuilder != null) {
            return widget.selectedItemBuilder!(
                context, _selectedOptions[index]);
          }
          return _buildChip(_selectedOptions[index], widget.chipConfig);
        }).toList());
  }

  /// Util method to map with index.
  Iterable<E> mapIndexed<E, F>(
      Iterable<F> items, E Function(int index, F item) f) sync* {
    var index = 0;

    for (final item in items) {
      yield f(index, item);
      index = index + 1;
    }
  }

  /// Get the chip separator.
  Widget _getChipSeparator(ChipConfig chipConfig) {
    if (chipConfig.separator != null) {
      return chipConfig.separator!;
    }

    return SizedBox(
      width: chipConfig.spacing,
    );
  }

  /// Buid the selected item chip.
  Widget _buildChip(ValueItem<T> item, ChipConfig chipConfig) {
    return SelectionChip<T>(
      item: item,
      chipConfig: chipConfig,
      onItemDelete: (removedItem) {
        widget.onOptionRemoved?.call(_options.indexOf(removedItem),
            _selectedOptions[_selectedOptions.indexOf(removedItem)]);

        _controller.clearSelection(removedItem);
        if (_focusNode.hasFocus) _focusNode.unfocus();
      },
    );
  }

  /// Get the selectedItem icon for the dropdown
  Widget? _getSelectedIcon(bool isSelected, Color primaryColor) {
    if (isSelected) {
      return widget.selectedOptionIcon ??
          Icon(
            Icons.check,
            color: primaryColor,
          );
    }
    if (!widget.alwaysShowOptionIcon) {
      return null;
    }

    final Icon icon = widget.selectedOptionIcon ??
        Icon(
          Icons.check,
          color: widget.optionTextStyle?.color ?? Colors.grey,
        );

    return icon;
  }

  /// Create the overlay entry for the dropdown.
  Widget buildOverlayEntry() {
    List<ValueItem<T>> options = _options;
    List<ValueItem<T>> selectedOptions = [..._selectedOptions];
    final searchController = TextEditingController();
    return StatefulBuilder(builder: ((context, dropdownState) {
      double screenHeight = MediaQuery.of(context).size.height;
      final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
      double bottomSheetHeight = keyboardHeight > 0 ? keyboardHeight : 0;
      double availableHeight = screenHeight - kToolbarHeight;
      double searchfieldheight = (widget.searchEnabled) ? 60 : 0;
      double contentHeight = options.length * 40.0 + 100 + searchfieldheight;
      double calculatedHeight =
          (contentHeight > availableHeight ? availableHeight : contentHeight) +
              bottomSheetHeight;
      return Container(
        decoration: BoxDecoration(
          color: widget.dropdownBackgroundColor ?? Colors.grey.shade50,
          borderRadius: widget.dropdownBorderRadius != null
              ? BorderRadius.circular(widget.dropdownBorderRadius!)
              : null,
        ),
        constraints:
            BoxConstraints.loose(Size(double.maxFinite, calculatedHeight)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.hint,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: widget.hintStyle!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    child: Icon(Icons.dangerous_outlined),
                    onTap: () {
                      Navigator.of(context).pop(-1);
                    },
                  )
                ],
              ),
            ),
            if (widget.searchEnabled) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: searchController,
                  onTapOutside: (_) {},
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  focusNode: _searchFocusNode,
                  decoration: InputDecoration(
                    fillColor:
                        widget.searchBackgroundColor ?? Colors.grey.shade200,
                    isDense: true,
                    filled: widget.searchBackgroundColor != null,
                    hintText: widget.searchLabel,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0.8,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 0.8,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        searchController.clear();
                        dropdownState(() {
                          options = _options;
                        });
                      },
                    ),
                  ),
                  onChanged: (value) {
                    dropdownState(() {
                      options = _options
                          .where((element) => element.label
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
              const Divider(
                height: 1,
              ),
            ],
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, __) =>
                    widget.optionSeparator ?? const SizedBox(height: 0),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  final isSelected = selectedOptions.contains(option);

                  onTap() {
                    if (widget.selectionType == SelectionType.multi) {
                      if (isSelected) {
                        dropdownState(() {
                          selectedOptions.remove(option);
                        });
                        setState(() {
                          _selectedOptions.remove(option);
                        });
                      } else {
                        final bool hasReachMax = widget.maxItems == null
                            ? false
                            : (_selectedOptions.length + 1) > widget.maxItems!;
                        if (hasReachMax) {
                          UiUtils.showToast(
                              "Maximum Limit is ${widget.maxItems}");
                          UiUtils.showToast("Maximum Limit Reached");
                          return;
                        }

                        dropdownState(() {
                          selectedOptions.add(option);
                        });
                        setState(() {
                          _selectedOptions.add(option);
                        });
                      }
                    } else {
                      dropdownState(() {
                        selectedOptions.clear();
                        selectedOptions.add(option);
                      });
                      setState(() {
                        _selectedOptions.clear();
                        _selectedOptions.add(option);
                      });
                      _focusNode.unfocus();
                    }

                    _controller.value._selectedOptions.clear();
                    _controller.value._selectedOptions.addAll(_selectedOptions);

                    widget.onOptionSelected?.call(_selectedOptions);
                  }

                  if (widget.optionBuilder != null) {
                    return InkWell(
                      onTap: onTap,
                      child: widget.optionBuilder!(context, option, isSelected),
                    );
                  }

                  final primaryColor = Theme.of(context).primaryColor;

                  return _buildOption(
                    option: option,
                    index: index,
                    primaryColor: primaryColor,
                    isSelected: isSelected,
                    dropdownState: dropdownState,
                    onTap: onTap,
                    selectedOptions: selectedOptions,
                  );
                },
              ),
            ),
          ],
        ),
      );
    }));
  }

  Widget _buildOption(
          {required ValueItem<T> option,
          required Color primaryColor,
          required int index,
          required bool isSelected,
          required StateSetter dropdownState,
          required void Function() onTap,
          required List<ValueItem<T>> selectedOptions}) =>
      Container(
        color: isSelected
            ? Colors.yellow // Change this to your desired color
            : (index % 2 == 0 ? Colors.grey[200] : Colors.white),
        child: ListTile(
            title: Text(option.label,
                style: widget.optionTextStyle ??
                    TextStyle(
                      fontSize: widget.hintFontSize,
                    )),
            autofocus: true,
            dense: true,
            enabled: !_disabledOptions.contains(option),
            onTap: onTap,
            trailing: _getSelectedIcon(isSelected, primaryColor)),
      );

  /// Clear the selected options.
  /// [MultiSelectController] is used to clear the selected options.
  void clear() {
    if (!_controller._isDisposed) {
      _controller.clearAllSelection();
    } else {
      setState(() {
        _selectedOptions.clear();
      });
      widget.onOptionSelected?.call(_selectedOptions);
    }
    if (_focusNode.hasFocus) _focusNode.unfocus();
  }

  /// handle the controller change.
  void _handleControllerChange() {
    // if the controller is null, return.
    if (_controller.isDisposed == true) return;

    // if current disabled options are not equal to the controller's disabled options, update the state.
    if (_disabledOptions != _controller.value._disabledOptions) {
      setState(() {
        _disabledOptions.clear();
        _disabledOptions.addAll(_controller.value._disabledOptions);
      });
    }

    // if current options are not equal to the controller's options, update the state.
    if (_options != _controller.value._options) {
      setState(() {
        _options.clear();
        _options.addAll(_controller.value._options);
      });
    }

    // if current selected options are not equal to the controller's selected options, update the state.
    if (_selectedOptions != _controller.value._selectedOptions) {
      setState(() {
        _selectedOptions.clear();
        _selectedOptions.addAll(_controller.value._selectedOptions);
      });
      widget.onOptionSelected?.call(_selectedOptions);
    }

    if (_selectionMode != _controller.value._isDropdownOpen) {
      if (_controller.value._isDropdownOpen) {
        _focusNode.requestFocus();
      } else {
        _focusNode.unfocus();
      }
    }
  }

  // get the container padding.
  EdgeInsetsGeometry _getContainerPadding() {
    if (widget.padding != null) {
      return widget.padding!;
    }
    return widget.selectionType == SelectionType.single
        ? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0)
        : const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0);
  }
}

/// MultiSelect Controller class.
/// This class is used to control the state of the MultiSelectDropdown widget.
/// This is just base class. The implementation of this class is in the MultiSelectController class.
/// The implementation of this class is hidden from the user.
class _MultiSelectController<T> {
  final List<ValueItem<T>> _disabledOptions = [];
  final List<ValueItem<T>> _options = [];
  final List<ValueItem<T>> _selectedOptions = [];
  bool _isDropdownOpen = false;
}

/// implementation of the MultiSelectController class.
class MultiSelectController<T>
    extends ValueNotifier<_MultiSelectController<T>> {
  MultiSelectController() : super(_MultiSelectController());

  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  /// set the dispose method.
  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }

  /// Clear the selected options.
  /// [MultiSelectController] is used to clear the selected options.
  void clearAllSelection() {
    value._selectedOptions.clear();
    notifyListeners();
  }

  /// clear specific selected option
  /// [MultiSelectController] is used to clear specific selected option.
  void clearSelection(ValueItem<T> option) {
    if (!value._selectedOptions.contains(option)) return;

    if (value._disabledOptions.contains(option)) {
      throw Exception('Cannot clear selection of a disabled option');
    }

    if (!value._options.contains(option)) {
      throw Exception(
          'Cannot clear selection of an option that is not in the options list');
    }

    value._selectedOptions.remove(option);
    notifyListeners();
  }

  void setSelectedOptions(List<ValueItem<T>> options) {
    if (options.any((element) => value._disabledOptions.contains(element))) {
      throw Exception('Cannot select disabled options');
    }

    if (options.any((element) => !value._options.contains(element))) {
      throw Exception('Cannot select options that are not in the options list');
    }

    value._selectedOptions.clear();
    value._selectedOptions.addAll(options);
    notifyListeners();
  }

  void addSelectedOption(ValueItem<T> option) {
    if (value._disabledOptions.contains(option)) {
      throw Exception('Cannot select disabled option');
    }

    if (!value._options.contains(option)) {
      throw Exception('Cannot select option that is not in the options list');
    }

    value._selectedOptions.add(option);
    notifyListeners();
  }

  /// set disabled options
  /// [MultiSelectController] is used to set disabled options.
  void setDisabledOptions(List<ValueItem<T>> disabledOptions) {
    if (disabledOptions.any((element) => !value._options.contains(element))) {
      throw Exception(
          'Cannot disable options that are not in the options list');
    }

    value._disabledOptions.clear();
    value._disabledOptions.addAll(disabledOptions);
    notifyListeners();
  }

  /// setDisabledOption method
  /// [MultiSelectController] is used to set disabled option.
  void setDisabledOption(ValueItem<T> disabledOption) {
    if (!value._options.contains(disabledOption)) {
      throw Exception('Cannot disable option that is not in the options list');
    }

    value._disabledOptions.add(disabledOption);
    notifyListeners();
  }

  /// set options
  /// [MultiSelectController] is used to set options.
  void setOptions(List<ValueItem<T>> options) {
    value._options.clear();
    value._options.addAll(options);
    notifyListeners();
  }

  /// get disabled options
  List<ValueItem<T>> get disabledOptions => value._disabledOptions;

  /// get enabled options
  List<ValueItem<T>> get enabledOptions => value._options
      .where((element) => !value._disabledOptions.contains(element))
      .toList();

  /// get options
  List<ValueItem<T>> get options => value._options;

  /// get selected options
  List<ValueItem<T>> get selectedOptions => value._selectedOptions;
}

/// [label] is the item that is displayed in the list. [value] is the value that is returned when the item is selected.
/// If the [value] is not provided, the [label] is used as the value.
/// An example of a [ValueItem] is:
/// ```dart
/// const ValueItem(label: 'Option 1', value: '1')
/// ```

class ValueItem<T> {
  /// The label of the value item
  final String label;

  /// The value of the value item
  final T? value;

  /// Default constructor for [ValueItem]
  const ValueItem({required this.label, required this.value});

  /// toString method for [ValueItem]
  @override
  String toString() {
    return 'ValueItem(label: $label, value: $value)';
  }

  /// toMap method for [ValueItem]
  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'value': value,
    };
  }

  /// fromMap method for [ValueItem]
  factory ValueItem.fromMap(Map<String, dynamic> map) {
    return ValueItem<T>(
      label: map['label'] ?? '',
      value: map['value'],
    );
  }

  /// toJson method for [ValueItem]
  String toJson() => json.encode(toMap());

  /// fromJson method for [ValueItem]
  factory ValueItem.fromJson(String source) =>
      ValueItem<T>.fromMap(json.decode(source));

  /// Equality operator for [ValueItem]
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueItem<T> &&
        other.label == label &&
        other.value == value;
  }

  /// Hashcode for [ValueItem]
  @override
  int get hashCode => label.hashCode ^ value.hashCode;

  /// CopyWith method for [ValueItem]
  ValueItem<T> copyWith({
    String? label,
    T? value,
  }) {
    return ValueItem<T>(
      label: label ?? this.label,
      value: value ?? this.value,
    );
  }
}

/// [SelectionType]
/// SelectionType enum for the selection type of the dropdown items.
/// * [single]: single selection
/// * [multi]: multi selection
enum SelectionType {
  single,
  multi,
}

/// [WrapType]
/// WrapType enum for the wrap type of the selected items.
/// * [WrapType.scroll]: scroll the selected items horizontally
/// * [WrapType.wrap]: wrap the selected items in both directions
enum WrapType { scroll, wrap }

/// [RequestMethod]
/// RequestMethod enum for the request method of the dropdown items.
/// * [RequestMethod.get]: get request
/// * [RequestMethod.post]: post request
/// * [RequestMethod.put]: put request
/// * [RequestMethod.delete]: delete request
/// * [RequestMethod.patch]: patch request
enum RequestMethod { get, post, put, patch, delete }

/// Configuration for the chip.
/// [backgroundColor] is the background color of the chip. Defaults to [Colors.white].
/// [padding] is the padding of the chip.
/// [radius] is the radius of the chip. Defaults to [BorderRadius.circular(18)].
///
/// [labelStyle] is the style of the label.
/// [labelPadding] is the padding of the label.
///
/// [deleteIcon] is the icon that is used to delete the chip.
/// [deleteIconColor] is the color of the delete icon.
///
/// [separator] is the separator between the chips. Default is a sized box with width of 8.
/// [spacing] is the width of the separator. If separator is provided, this value is ignored.
///
/// [wrapType] is the type of the chip. Default is [WrapType.scroll]. [WrapType.wrap] will wrap the chips to next line if there is not enough space. [WrapType.scroll] will scroll the chips.
///  * [WrapType.scroll] is used to scroll the chips.
///  * [WrapType.wrap] is used to wrap the chips in a row.
///
///
///
///
/// An example of a [ChipConfig] is:
/// ```dart
/// const ChipConfig(
///   deleteIcon: Icon(Icons.delete, color: Colors.red),
///   wrapType: WrapType.scroll,
///   separator: const Divider(),
///   padding: const EdgeInsets.all(8),
///   labelStyle: TextStyle(fontSize: 16),
///   labelPadding: const EdgeInsets.symmetric(horizontal: 8),
///   radius: BorderRadius.circular(18),
///   backgroundColor: Colors.white,
///   )
/// ```

class ChipConfig {
  final Icon? deleteIcon;

  final Color deleteIconColor;
  final Color labelColor;
  final Color? backgroundColor;

  final TextStyle? labelStyle;
  final EdgeInsets padding;
  final EdgeInsets labelPadding;

  final double radius;
  final double spacing;
  final double runSpacing;

  final Widget? separator;

  final WrapType wrapType;

  final bool autoScroll;

  const ChipConfig({
    this.deleteIcon,
    this.deleteIconColor = Colors.white,
    this.backgroundColor,
    this.padding = const EdgeInsets.only(left: 12, top: 0, right: 4, bottom: 0),
    this.radius = 18,
    this.spacing = 8,
    this.runSpacing = 8,
    this.separator,
    this.labelColor = Colors.white,
    this.labelStyle,
    this.wrapType = WrapType.scroll,
    this.labelPadding = EdgeInsets.zero,
    this.autoScroll = false,
  });
}

class HintText extends StatelessWidget {
  final TextStyle? hintStyle;
  final String hintText;
  final Color? hintColor;
  final EdgeInsetsGeometry? hintPadding;

  const HintText({
    Key? key,
    this.hintStyle,
    required this.hintText,
    this.hintColor,
    this.hintPadding,
  }) : super(key: key);

  static const EdgeInsetsGeometry hintPaddingDefault =
      EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: hintPadding ?? hintPaddingDefault,
      child: Text(
        hintText,
        // overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: hintStyle ??
            TextStyle(
              fontSize: 13,
              color: hintColor ?? Colors.grey.shade300,
            ),
      ),
    );
  }
}

class SingleSelectedItem extends StatelessWidget {
  /// [label] is the selected item label.
  final String label;

  final TextStyle? style;

  const SingleSelectedItem({
    required this.label,
    this.style,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        label,
        style: style ??
            TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
      ),
    );
  }
}

class SelectionChip<T> extends StatelessWidget {
  final ChipConfig chipConfig;
  final Function(ValueItem<T>) onItemDelete;
  final ValueItem<T> item;

  const SelectionChip({
    Key? key,
    required this.chipConfig,
    required this.item,
    required this.onItemDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints.tightFor(),
      padding: chipConfig.padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.yellow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              item.label,
              softWrap: true,
              style: chipConfig.labelStyle ??
                  TextStyle(color: chipConfig.labelColor, fontSize: 14),
            ),
          ),
          chipConfig.deleteIcon != null
              ? GestureDetector(
                  onTap: () => onItemDelete(item), child: chipConfig.deleteIcon)
              : Container(),
        ],
      ),
    );
  }
}
