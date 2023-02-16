import 'package:flutter/material.dart';

class SwitchProvider extends ChangeNotifier {
  bool _masterSwitchValue = false;
  bool _subSwitch1Value = false;
  bool _subSwitch2Value = false;
  bool _subSwitch3Value = false;

  bool get masterSwitchValue => _masterSwitchValue;
  bool get subSwitch1Value => _subSwitch1Value;
  bool get subSwitch2Value => _subSwitch2Value;
  bool get subSwitch3Value => _subSwitch3Value;

  set masterSwitchValue(bool value) {
    if (_masterSwitchValue != value) {
      _masterSwitchValue = value;
      _subSwitch1Value = value;
      _subSwitch2Value = value;
      _subSwitch3Value = value;
      notifyListeners();
    }
  }

  set subSwitch1Value(bool value) {
    if (_subSwitch1Value != value) {
      _subSwitch1Value = value;
      _updateMasterSwitchValue();
      notifyListeners();
    }
  }

  set subSwitch2Value(bool value) {
    if (_subSwitch2Value != value) {
      _subSwitch2Value = value;
      _updateMasterSwitchValue();
      notifyListeners();
    }
  }

  set subSwitch3Value(bool value) {
    if (_subSwitch3Value != value) {
      _subSwitch3Value = value;
      _updateMasterSwitchValue();
      notifyListeners();
    }
  }

  void _updateMasterSwitchValue() {
    if (!_subSwitch1Value && !_subSwitch2Value && !_subSwitch3Value) {
      _masterSwitchValue = false;
    } else {
      _masterSwitchValue = true;
    }
    notifyListeners();
  }
}
