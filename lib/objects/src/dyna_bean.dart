part of objects;

class DynaBean {
  Map<dynamic, Object> map;
  
  DynaBean() {
    this.map = new Map();
  }
  
  DynaBean.asMap(Map map) {
    this.map = map;
  }
  
  dynamic get(String key) {
    return this.map[key];
  }
  
  dynamic set(String key, dynamic value) {
    this.map[key] = value;
  }
}

