[![Pub](https://img.shields.io/badge/Pub-1.1.1-orange.svg)](https://pub.dartlang.org/packages/country_code_picker)

# country_code_picker

A flutter package for showing a country code selector.

<div style="display:flex;flex-direction:row;">
        <img src="screenshots/screen1.png" alt="screen_01" height="300" />
        <img src="screenshots/screen2.png" alt="screen_02" height="300" />
</div>

## Usage

Just put the component in your application setting the onChanged callback.

 ```dart

 @override
  Widget build(BuildContext context) => new Scaffold(
      body: new Center(
        child: new CountryCodePicker(
          onChanged: print,
          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
          initialSelection: 'IT',
          favorite: ['+39','FR'],
        ),
      ),
  );

 ```
Note: Your onChanged function can be any function of the type shown below:

```dart
(CountryCode)->dynamic

```
Example:

```dart

void _onCountryChange(CountryCode countryCode) {
    //Todo : manipulate the selected country code here
    print("New Country selected: " + countryCode.toString());
  }
  
```


## Contributions
Contributions of any kind are more than welcome! Feel free to fork and improve country_code_picker in any way you want, make a pull request, or open an issue.
