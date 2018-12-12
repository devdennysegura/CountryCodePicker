import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:flutter/material.dart';

class FlagDialDropDown extends StatefulWidget {
  final List<Map> jsonList = codes;
  final TextStyle textStyle;

  FlagDialDropDown({this.textStyle});

  @override
  State<StatefulWidget> createState() => _FlagDialDropDownState();
}

class _FlagDialDropDownState extends State<FlagDialDropDown> {
  List<CountryCode> elements = [];
  CountryCode selectedItem;
  final String timeZone = DateTime.now().timeZoneName;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<CountryCode>(
          items: elements.map((CountryCode value) {
            return DropdownMenuItem<CountryCode>(
              value: value,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Image.asset(
                        value.flagUri,
                        package: 'country_code_picker',
                        width: 32.0,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      value.toString(),
                      style: widget.textStyle ??
                          Theme.of(context).textTheme.button,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          value: selectedItem,
          onChanged: _selectItem,
        ),
      ),
    );
  }

  @override
  void initState() {
    elements = widget.jsonList.map((s) {
      print(s);
      return CountryCode(
          name: s['name'],
          code: s['code'],
          dialCode: s['dial_code'],
          mask: s['mask'],
          flagUri: 'flags/${s['code'].toLowerCase()}.png',
          timeZone: s['time_zone']);
    }).toList();
    selectedItem = elements.firstWhere(
        (e) => (e.timeZone.toUpperCase() == timeZone.toUpperCase()),
        orElse: () => elements[0]);
    super.initState();
  }

  void _selectItem(CountryCode e) {
    setState(() => selectedItem = e);
    Navigator.pop(context, e);
  }
}
