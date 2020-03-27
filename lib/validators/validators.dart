class StringValidMessages {
  String minLength = "Minimum length";
  String maxLength = "Maximum length";
  String pattern = "Invalid pattern";

  StringValidMessages({this.minLength, this.maxLength, this.pattern});
}

class StringValidErrors {
  String minLength;
  String maxLength;
  String pattern;

  StringValidErrors({this.minLength, this.maxLength, this.pattern});
}

class StringValid {
  Set<String Function(String)> _callbacks = Set();

  int _minLength;
  int _maxLength;
  RegExp _pattern;

  StringValidMessages messages;

  StringValid({int minLength, int maxLength, RegExp pattern, this.messages}) {
    _minLength = minLength;
    _maxLength = maxLength;
    _pattern = pattern;
    if (minLength != null) _callbacks.add(errorMinLength);
    if (maxLength != null) _callbacks.add(errorMaxLength);
    if (pattern != null) _callbacks.add(errorPattern);
  }

  String firstError(String val) {
    for (var c in _callbacks) {
      final error = c(val);
      if (error != null) return error;
    }
    return null;
  }

  StringValidErrors errors(String val) {
    final errors = StringValidErrors();
    for (var c in _callbacks) {
      final error = c(val);
      if (error != null) {
        if (c == errorMinLength) {
          errors.minLength = error;
        } else if (c == errorMaxLength) {
          errors.maxLength = error;
        } else if (c == errorPattern) {
          errors.pattern = error;
        }
      }
    }
    return errors;
  }

  List<String> errorList(String val) {
    final errorList = List<String>();
    for (var c in _callbacks) {
      final error = c(val);
      if (error != null) errorList.add(error);
    }
    return errorList;
  }

  bool valid(String val) {
    return firstError(val) == null;
  }

  //////////////////
  ////////////////// Minimum length

  StringValid minLength(int min, {String message}) {
    _minLength = min;
    if (message != null) messages.minLength = message;
    if (min != null)
      _callbacks.add(errorMinLength);
    else
      _callbacks.remove(errorMinLength);
    return this;
  }

  String errorMinLength(String val) {
    if (val.length < _minLength) return messages.minLength;
    return null;
  }

  //////////////////
  ////////////////// Maximum length

  StringValid maxLength(int max, {String message}) {
    _maxLength = max;
    if (message != null) messages.maxLength = message;
    if (max != null)
      _callbacks.add(errorMaxLength);
    else
      _callbacks.remove(errorMaxLength);
    return this;
  }

  String errorMaxLength(String val) {
    if (val.length > _maxLength) return messages.maxLength;
    return null;
  }

  //////////////////
  ////////////////// Pattern

  StringValid pattern(RegExp pattern, {String message}) {
    _pattern = pattern;
    if (message != null) messages.pattern = message;
    if (pattern != null)
      _callbacks.add(errorPattern);
    else
      _callbacks.remove(errorPattern);
    return this;
  }

  String errorPattern(String val) {
    if (!_pattern.hasMatch(val)) return messages.pattern;
    return null;
  }
}
