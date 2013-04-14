part of objects;

/*
class Person {
  String firstname;
  String lastname;
  int age;
  String email;
  
  Person(String this.firstname, String this.lastname, int this.age, String this.email);
}*/

class Person extends DynaBean {
  static final String fn = 'firstname';
  static final String ln = 'lastname';
  static final String ag = 'age';
  static final String em = 'email';
  
  Person.empty() : super();
  
  Person.map(Map map) : super.asMap(map);
  
  Person.asDynaBean(DynaBean dynaBean) : super.asMap(dynaBean.map);
  
  Person(String firstName, String lastName, int age, String email) : super() {
    this.firstname = firstName;
    this.lastname = lastName;
    this.email = email;
    
    if (age != null) {
      this.age = age;
    }
  }
  
  void set firstname(v) {map[fn] = v;}
  void set lastname(v) {map[ln] = v;}
  void set age(v) {map[ag] = v;}
  void set email(v) {map[em] = v;}
  
  String get firstname => map[fn];
  String get lastname => map[ln];
  int get age => map[ag];
  String get email => map[em];
}