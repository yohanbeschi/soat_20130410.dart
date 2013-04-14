part of views;

class UserFormView extends FormView {
  Element container;
  Element form;
  Tree errors;
  
  TextInputElement firstname;
  TextInputElement lastname;
  TextInputElement age;
  TextInputElement email;
  SubmitButtonInputElement button;
  
  List<Person> persons;
  String action;
  
  UserFormView(List<Person> this.persons, String this.action) {
    container = new DivElement();
    form = new FormElement();
    
    firstname = buildInput('firstname', type:'text', binding:'true', validation:'requiredString'); //new TextInputElement();
    lastname = buildInput('lastname', type:'text', binding:'true', validation:'requiredString'); //new TextInputElement();
    age = buildInput('age', type:'text', binding:'true', validation:'requiredInt'); //new TextInputElement();
    email = buildInput('email', type:'text', binding:'true', validation:'requiredEmail'); //new TextInputElement();
    button = new SubmitButtonInputElement();
    button.value = 'CreateUser';
    
    TableElement table = new TableElement()
      ..append(new TableRowElement()
                   ..append(new TableCellElement()
                             ..append(new SpanElement()
                                        ..text = 'Firstname *: '))
                   ..append(new TableCellElement()
                             ..append(firstname)))
      ..append(new TableRowElement()
                   ..append(new TableCellElement()
                             ..append(new SpanElement()
                                        ..text = 'Lastname *: '))
                   ..append(new TableCellElement()
                             ..append(lastname)))
    ..append(new TableRowElement()
                   ..append(new TableCellElement()
                             ..append(new SpanElement()
                                        ..text = 'Age *: '))
                   ..append(new TableCellElement()
                             ..append(age)))
    ..append(new TableRowElement()
                   ..append(new TableCellElement()
                             ..append(new SpanElement()
                                        ..text = 'Email *: '))
                    ..append(new TableCellElement()
                             ..append(email)))
    ..append(new TableRowElement()
                    ..append(new TableCellElement()
                              ..colSpan = 2
                              ..classes.add('center')      
                              ..append(button)));
    
    form.append(table);
    errors = new Tree([new TreeConfig((e) => e)]);
    errors.addTo(container, 'afterBegin');
    
    container.append(form);
    
    bind();
  }
  
  void bind() {
    button.onClick.listen(createUser);
  }
  
  void createUser(Event e) {
    e.preventDefault();
    e.stopPropagation();
    
    final ValidationResult results = this.validate();
    
    if (results.data != null) {
      //var person = new Person(firstname.value, lastname.value, int.parse(age.value), email.value); 
      persons.add(new Person.asDynaBean(results.data));
      window.location.hash = "#user:list";
    } else {
      errors.setData(results.errors);
    }
  }
  
  Element asWidget() => this.container;
  Element getOrigin() => this.form;
}