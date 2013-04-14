part of utils;

final RegExp EMAIL_VALIDATION = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

bool isEmpty(String s) => s == null;

bool isNotEmpty(String s) => !isEmpty(s);

bool isBlank(String s) => isEmpty(s) || s.length == 0;

bool isNotBlank(String s) => !isBlank(s);

bool isSpace(String s) => isNotBlank(s) && (s == ' ' || s == '\t');

bool isAlpha(String value) {
  for (int char in value.codeUnits) {
    if (char < 65 || char > 90 && char < 97 || char > 122) {
      return false;
    }
  }
  
  return true;
}

bool isEmail(String value) => EMAIL_VALIDATION.hasMatch(value);