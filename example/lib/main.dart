import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/text_input.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MaskedTextController controller =
      new MaskedTextController(mask: '00 0000-0000', text: '1158131276');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CountryPicker Example'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: FlagTextInput(
            where: {'path': 'tz', 'value': 'America'},
            initByTimeZone: true,
            label: 'Telefono',
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.black, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(8.0),
            ),
            onChange: (Map<String, dynamic> v) {
              print('hola bebe $v');
            },
          ),
        ),
      ),
    );
  }
}
