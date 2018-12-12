library country_code_picker;

import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:country_code_picker/selection_dialog.dart';
import 'package:flutter/material.dart';

export 'country_code.dart';

class CountryCodePicker extends StatefulWidget {
  final ValueChanged<CountryCode> onChanged;
  final String initialSelection;
  final List<String> favorite;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final dynamic filterBy;
  final bool initWithTimeZone;
  final String timeZone = DateTime.now().timeZoneName.toUpperCase();

  CountryCodePicker({
    this.onChanged,
    this.initialSelection,
    this.favorite = const [],
    this.textStyle,
    this.padding = const EdgeInsets.all(0.0),
    this.filterBy,
    this.initWithTimeZone,
  });

  @override
  State<StatefulWidget> createState() {
    List<Map> jsonList = codes;
    if (filterBy != null)
      jsonList = jsonList
          .where((c) => c[filterBy['path']] == filterBy['value'])
          .toList();
    List<CountryCode> elements = jsonList
        .map((s) => CountryCode(
            name: s['name'],
            code: s['code'],
            dialCode: s['dial_code'],
            mask: s['mask'],
            flagUri: 'flags/${s['code'].toLowerCase()}.png',
            timeZone: s['time_zone'],
            tz: s['tz']))
        .toList();
    return _CountryCodePickerState(elements);
  }
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  CountryCode selectedItem;
  List<CountryCode> elements = [];
  List<CountryCode> favoriteElements = [];

  _CountryCodePickerState(this.elements);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                selectedItem.flagUri,
                package: 'country_code_picker',
                width: 32.0,
              ),
            ),
          ),
          Flexible(
            child: Text(
              selectedItem.toString(),
              style: widget.textStyle ?? Theme.of(context).textTheme.button,
            ),
          ),
        ],
      ),
      onPressed: _showSelectionDialog,
    );
  }

  @override
  initState() {
    if (widget.initWithTimeZone != null && widget.initWithTimeZone) {
      selectedItem = elements.firstWhere(
          (e) => e.timeZone.toUpperCase() == widget.timeZone,
          orElse: () => elements[0]);
    } else {
      selectedItem = elements[0];
    }

    favoriteElements = elements
        .where((e) =>
            widget.favorite.firstWhere(
                (f) => e.code == f.toUpperCase() || e.dialCode == f.toString(),
                orElse: () => null) !=
            null)
        .toList();
    super.initState();

    if (mounted) {
      _publishSelection(selectedItem);
    }
  }

  void _showSelectionDialog() {
    showDialog<CountryCode>(
      context: context,
      builder: (_) => SelectionDialog(elements, favoriteElements),
    ).then((CountryCode e) {
      if (e != null) {
        setState(() {
          selectedItem = e;
        });
        _publishSelection(e);
      }
    });
  }

  void _publishSelection(CountryCode e) {
    if (mounted && widget.onChanged != null) {
      widget.onChanged(e);
    }
  }
}
