import '../lib/myapp_lib.dart';

void main() {
  window.onHashChange.listen(changePage);
  
  if (window.location.hash == null || window.location.hash.isEmpty) {
    window.location.hash = "#user:list";
    window.history.replaceState(null, '', '${window.location.pathname}#user:list');
  } else {
    window.dispatchEvent(new Event('hashchange'));
  }
}

void changePage(Event e) {
  //print('__${window.location.hash}');
  
  final Element container = query('#container');
  
  String hash = window.location.hash;
  if (hash != null && !hash.isEmpty) {
    hash = hash.replaceFirst('#', '');
    final List<String> place = hash.split(':');
    
    var view;
    
    if (place[0] == 'user') {
      if (place[1] == 'list') {
        view = new UserListView(persons);
      } else {
        view = new UserFormView(persons, place[1]);
      }
    }
    
    container.children.clear();
    container.append(view.container);
  }
}

List<Person> _persons;

List<Person> get persons {
  if (_persons == null) {
    _persons = [new Person('Carson', 'Busses', 25, 'carson.busses@fake.fr'),
      new Person('Patty', 'Cake', 72, 'patty.cake@fake.fr'),
      new Person('Anne', 'Derri ', 14, 'anne.derri@fake.fr'),
      new Person('Moe', 'Dess', 47, 'moe.dess@fake.fr'),
      new Person('Leda', 'Doggslife', 50, 'leda.doggslife@fake.fr'),
      new Person('Dan', 'Druff', 38, 'dan.druff@fake.fr'),
      new Person('Al', 'Fresco', 36, 'al.fresco@fake.fr'),
      new Person('Ido', 'Hoe', 2, 'ido.heo@fake.fr'),
      new Person('Howie', 'Kisses', 23, 'howie.kisses@fake.fr'),
      new Person('Len', 'Lease', 63, 'len.lease@fake.fr')];
  }
    
  return _persons;
}