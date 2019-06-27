library country_code_picker;

import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:country_code_picker/selection_dialog.dart';
import 'package:flutter/material.dart';

export 'country_code.dart';

class PrefixCountryPicker extends StatefulWidget {
  final ValueChanged<CountryCode> onChanged;
  final String initialSelection;
  final List<String> favorite;
  final dynamic filterBy;
  final bool initWithTimeZone;
  final double width;
  final EdgeInsets margin;
  final String timeZone;
  final String initFlag;

  PrefixCountryPicker(
      {this.onChanged,
      this.initialSelection,
      this.favorite = const [],
      this.filterBy,
      this.initWithTimeZone,
      this.margin,
      this.width,
      this.initFlag})
      : timeZone = DateTime.now().timeZoneName.toUpperCase();

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
    return _PrefixCountryPickerState(elements);
  }
}

class _PrefixCountryPickerState extends State<PrefixCountryPicker> {
  CountryCode selectedItem;
  List<CountryCode> elements = [];
  List<CountryCode> favoriteElements = [];

  _PrefixCountryPickerState(this.elements);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: Container(
        margin: widget.margin,
        child: Image.asset(
          selectedItem.flagUri,
          package: 'country_code_picker',
          width: widget.width,
        ),
      ),
      onTap: _showSelectionDialog,
    );
  }

  @override
  void initState() {
    if (widget.initFlag != null) {
      selectedItem = elements.firstWhere(
          (e) => e.code.toUpperCase() == widget.initFlag,
          orElse: () => elements[0]);
    } else if (widget.initWithTimeZone != null && widget.initWithTimeZone) {
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
    FocusScope.of(context).requestFocus(FocusNode());
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
