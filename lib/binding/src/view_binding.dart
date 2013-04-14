part of binding;

class ValidationResult {
  var data;
  List<String> errors;
}

/**
 * Data binding.
 */
abstract class BindingView<T extends DynaBean> {
  void unload(T obj) {
    this._getFields().forEach((e) => e.name = obj.get(e.value));
  }
  
  List _getFields() {
    final Element origin = this.getOrigin();
    final List<Element> formFields = origin.queryAll('*')
       .where((e) => e.dataset['binding'] != null);
    return formFields;
  }
  
  Element asWidget();
  Element getOrigin();
}

/**
 * Automatic form validation
 */
abstract class FormView<T extends DynaBean> extends BindingView<T> {
  
  Map<String, Function> validators = {'requiredString':validateString, 'string':validateString,
                                      'requiredInt':validateInt, 'int':validateInt,
                                      'requiredEmail':validateEmail, 'email':validateEmail};
  
  void load(final T obj) {
    this._getFields().forEach((e) => obj.set(e.name, e.value));
  }
  
  ValidationResult validate() {
    // Set errors
    final List<String> errors = new List();
    final Element origin = this.getOrigin();
    final List<Element> formFields = origin.queryAll('*').where((e) => e.dataset['validation'] != null).toList();
 
    var bean = new DynaBean();
    for(var e in formFields) { 
      final String error = this._validate(bean, e.name, e.value, e.dataset['validation']);
      if (error != null && !error.isEmpty) {
        errors.add(error);
      }
    }

    var result = new ValidationResult();
    if (errors.length > 0) {
      result.errors = errors;
    } else {
      result.data = bean;
    }
    
    return result;
  }
  
  String _validate(DynaBean bean, String name, String value, String validation) {
    if (validation.startsWith('required') && isBlank(value)) {
      return 'The field $name is required';
    }

    return validators[validation](bean, name, value);;
  }
}

/**
 * String validator
 */
validateString(DynaBean bean, String name, String value) {
  if (!isAlpha(value)) {
    return 'The field $name must be a String';
  } else {
    bean.set(name, value);
  }
}

/**
 * Integer validator
 */
validateInt(DynaBean bean, String name, String value) {
  if (!isInt(value)) { 
    return 'The field $name must be an Integer';
  } else {
    bean.set(name, int.parse(value));
  }
}

/**
 * Email validator
 */
validateEmail(DynaBean bean, String name, String value) {
  if (!isEmail(value)) {
    return 'The field $name must be a valid Email';
  } else {
    bean.set(name, value);
  }
}

/**
 * Validatable input
 */
InputElement buildInput(String name, {String type, String binding, String validation}) {
  final InputElement input = new InputElement(type : type);
  input.autofocus = true;
  
  if (binding != null) {
    input.dataset['binding'] = binding;
  }
  
  if (validation != null) {
    input.dataset['validation'] = validation;
  }
  
  input.name = name;
  return input;
}