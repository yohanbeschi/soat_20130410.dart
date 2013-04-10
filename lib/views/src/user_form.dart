part of views;

class UserFormView {
  FormElement container;
  
  TextInputElement firstname;
  TextInputElement lastname;
  TextInputElement age;
  TextInputElement email;
  SubmitButtonInputElement button;
  
  List<Person> persons;
  String action;
  
  UserFormView(List<Person> this.persons, String this.action) {
    container = new FormElement();
    
    firstname = new TextInputElement();
    lastname = new TextInputElement();
    age = new TextInputElement();
    email = new TextInputElement();
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
                                        ..text = 'Age: '))
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
    container.append(table);
    
    bind();
  }
  
  void bind() {
    button.onClick.listen(createUser);
  }
  
  void createUser(Event e) {
    print('submit');
    var person = new Person(firstname.value, lastname.value, int.parse(age.value), email.value); 
    persons.add(person);
    window.location.hash = "#user:list";
    
    e.preventDefault();
    e.stopPropagation();
  }
}