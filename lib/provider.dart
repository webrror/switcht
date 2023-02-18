import 'package:flutter/material.dart';

//* For FIXED Number of switches

// class SwitchProvider extends ChangeNotifier {
//   bool _masterSwitchValue = false;
//   bool _subSwitch1Value = false;
//   bool _subSwitch2Value = false;
//   bool _subSwitch3Value = false;

//   bool get masterSwitchValue => _masterSwitchValue;
//   bool get subSwitch1Value => _subSwitch1Value;
//   bool get subSwitch2Value => _subSwitch2Value;
//   bool get subSwitch3Value => _subSwitch3Value;

//   set masterSwitchValue(bool value) {
//     if (_masterSwitchValue != value) {
//       _masterSwitchValue = value;
//       _subSwitch1Value = value;
//       _subSwitch2Value = value;
//       _subSwitch3Value = value;
//       notifyListeners();
//     }
//   }

//   set subSwitch1Value(bool value) {
//     if (_subSwitch1Value != value) {
//       _subSwitch1Value = value;
//       _updateMasterSwitchValue();
//       notifyListeners();
//     }
//   }

//   set subSwitch2Value(bool value) {
//     if (_subSwitch2Value != value) {
//       _subSwitch2Value = value;
//       _updateMasterSwitchValue();
//       notifyListeners();
//     }
//   }

//   set subSwitch3Value(bool value) {
//     if (_subSwitch3Value != value) {
//       _subSwitch3Value = value;
//       _updateMasterSwitchValue();
//       notifyListeners();
//     }
//   }

//   void _updateMasterSwitchValue() {
//     if (!_subSwitch1Value && !_subSwitch2Value && !_subSwitch3Value) {
//       _masterSwitchValue = false;
//     } else {
//       _masterSwitchValue = true;
//     }
//     notifyListeners();
//   }
// }

//* For ANY Number of switches

class AllProvider with ChangeNotifier {
  bool _masterSwitchValue = false;
  List<bool> _subSwitchValues = [];

  Color _colorScheme = Colors.red;
  Color get colorScheme => _colorScheme;

  void updateColorScheme(Color color) {
    _colorScheme = color;
    notifyListeners();
  }

  AllProvider(int numSubSwitches) {
    for (int i = 0; i < numSubSwitches; i++) {
      _subSwitchValues.add(false);
    }
  }

  bool get masterSwitchValue => _masterSwitchValue;
  set masterSwitchValue(bool value) {
    _masterSwitchValue = value;
    if (!value) {
      // If the master switch is turned off, turn off all sub-switches.
      for (int i = 0; i < _subSwitchValues.length; i++) {
        _subSwitchValues[i] = false;
      }
    }
    notifyListeners();
  }

  List<bool> get subSwitchValues => _subSwitchValues;
  set subSwitchValues(List<bool> values) {
    _subSwitchValues = values;
    if (_subSwitchValues.contains(true)) {
      // If any sub-switch is turned on, turn on the master switch.
      _masterSwitchValue = true;
    } else {
      // If all sub-switches are turned off, turn off the master switch.
      _masterSwitchValue = false;
    }
    notifyListeners();
  }
}
