import '../lib/myapp_lib.dart';

void main() {
  final UserListView view = new UserListView(persons);
  view.addTo('#container');
}

List<Person> get persons 
  => [new Person('Carson', 'Busses', 25, 'carson.busses@fake.fr'),
      new Person('Patty', 'Cake', 72, 'patty.cake@fake.fr'),
      new Person('Anne', 'Derri ', 14, 'anne.derri@fake.fr'),
      new Person('Moe', 'Dess', 47, 'moe.dess@fake.fr'),
      new Person('Leda', 'Doggslife', 50, 'leda.doggslife@fake.fr'),
      new Person('Dan', 'Druff', 38, 'dan.druff@fake.fr'),
      new Person('Al', 'Fresco', 36, 'al.fresco@fake.fr'),
      new Person('Ido', 'Hoe', 2, 'ido.heo@fake.fr'),
      new Person('Howie', 'Kisses', 23, 'howie.kisses@fake.fr'),
      new Person('Len', 'Lease', 63, 'len.lease@fake.fr'),];