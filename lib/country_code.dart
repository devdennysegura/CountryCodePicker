mixin ToAlias {}

@deprecated
class CElement = CountryCode with ToAlias;

/// Country element. This is the element that contains all the information
class CountryCode {
  String name;
  String flagUri;
  String code;
  String dialCode;
  String timeZone;
  String mask;
  String tz;

  CountryCode({
    this.name,
    this.flagUri,
    this.code,
    this.dialCode,
    this.mask,
    this.timeZone,
    this.tz,
  });

  @override
  String toString() => '$dialCode';

  String toLongString() => '$name';
  Map<String, dynamic> toJSON() => {'name': name, 'code': dialCode, 'mask': mask};
}
