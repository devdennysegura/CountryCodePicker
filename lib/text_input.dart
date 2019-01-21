import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter/material.dart';

class FlagTextInput extends StatefulWidget {
  final Function onChange;
  final dynamic where;
  final bool initByTimeZone;
  final String label;
  final String hintText;
  final TextStyle style;
  final TextStyle labelStyle;
  final TextStyle hinTextStyle;
  final EdgeInsetsGeometry contentPadding;
  final Widget suffix;
  final InputBorder border;
  final InputBorder focusedBorder;

  FlagTextInput({
    this.onChange,
    this.where,
    this.initByTimeZone,
    this.style,
    this.label,
    this.labelStyle,
    this.hintText,
    this.hinTextStyle,
    this.contentPadding,
    this.suffix,
    this.border,
    this.focusedBorder,
  });

  @override
  State<StatefulWidget> createState() => FlagTextInputState(
        onChange,
        where,
        initByTimeZone,
        style,
        label,
        labelStyle,
        hintText,
        hinTextStyle,
        contentPadding,
        suffix,
        border,
        focusedBorder,
      );
}

class FlagTextInputState extends State<FlagTextInput> {
  List<CountryCode> elements = [];
  CountryCode selectedItem;
  final MaskedTextController controller =
      MaskedTextController(mask: '', text: '');
  final Function onChange;
  final dynamic where;
  final bool initByTimeZone;
  final String label;
  final String hintText;
  final TextStyle style;
  final TextStyle labelStyle;
  final TextStyle hinTextStyle;
  final EdgeInsetsGeometry contentPadding;
  final Widget suffix;
  final InputBorder border;
  final InputBorder focusedBorder;

  FlagTextInputState(
    this.onChange,
    this.where,
    this.initByTimeZone,
    this.style,
    this.label,
    this.labelStyle,
    this.hintText,
    this.hinTextStyle,
    this.contentPadding,
    this.suffix,
    this.border,
    this.focusedBorder,
  );

  void onChangeFlag(CountryCode cc) {
    String mask = cc.mask ?? '';
    mask = mask.isEmpty ? '000000000000' : mask;
    selectedItem = cc;
    controller.updateMask(cc.mask);
    publishDetail(null);
  }

  void publishDetail(String text) {
    try {
      Map<String, dynamic> value = Map.from(selectedItem.toJSON());
      value.addAll({'text': text ?? controller.text});
      this.onChange(value);
    } catch (e) {
      debugPrint(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      onChanged: publishDetail,
      style: style,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        suffixIcon: suffix,
        border: border,
        focusedBorder: focusedBorder,
        prefixIcon: Container(
          child: CountryCodePicker(
            onChanged: onChangeFlag,
            filterBy: where,
            textStyle: style,
          ),
        ),
        labelText: label,
        hintText: hintText,
        labelStyle: labelStyle,
        hintStyle: hinTextStyle,
      ),
    );
  }
}
