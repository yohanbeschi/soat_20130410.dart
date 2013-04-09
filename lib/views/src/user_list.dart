part of views;

class UserListView {
  Element container;
  
  UserListView (List<Person> persons) {
    final Table table = new Table<Person>(sorting:true)
        ..addColumn('Firstname', new TextCell((Person o) => o.firstname))
        ..addColumn('Lastname', new TextCell((Person o) => o.lastname))
        ..addColumn('Age', new TextCell((Person o) => o.age))
        ..addColumn('Email', new TextCell((Person o) => o.email))
        ..setData(persons);
    
    final CheckboxInputElement multiContext = new CheckboxInputElement();
    
    final TextInputElement search = new TextInputElement();
    search.onKeyUp.listen((e) {
      final String value = search.value.toLowerCase();
      table.setData(persons.where((e) {
        bool filter = e.firstname.toLowerCase().contains(value) 
            || e.lastname.toLowerCase().contains(value);
        if (multiContext.checked) {
          return filter || e.age.toString().toLowerCase().contains(value) || e.email.toLowerCase().contains(value);
        } else {
          return filter;
        }
        
      }).toList());
    });
    
    container = new DivElement();
    container.append(search);
    container.append(multiContext);
    container.append(table.table);
  }
  
  void addTo(String selector, [String where = 'beforeEnd']) {
    query(selector).insertAdjacentElement(where, container);
  }
}