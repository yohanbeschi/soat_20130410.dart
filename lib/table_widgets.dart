import 'dart:html';

typedef String CellContent<D>(D obj);

abstract class Cell<D> {
  CellContent<D> data;
  
  Cell(this.data);
  
  Element getElement(D obj);
  
  int compare(D o1, D o2) {
    return this.data(o1).compareTo(this.data(o2));
  }
  
  int reverse(D o1, D o2) {
    return -this.compare(o1, o2);
  }
}

class TextCell<D> extends Cell<D> {
  TextCell(CellContent<D> f) : super(f);

  Element getElement(D obj) {
    SpanElement element = new SpanElement();
    element.text = this.data(obj).toString();
    return element;
  }
}

class Table<D> {
  List<D> data;
  List<Cell<D>> cells;
  
  TableElement table;
  Element header;
  Element tbody;
  
  bool sorting;
  
  Table({bool sorting:false}) {
    this.sorting = sorting;
    
    this.table = new TableElement();
    this.header = new TableRowElement();
    this.tbody = new Element.tag('tbody');
    
    this.table.append(this.header);
    this.table.append(tbody);
    
    this.cells = new List();
  }
  
  void addColumn(String header, Cell cell) {
    Element th = new Element.tag('th');
    th.dataset['col'] = this.cells.length.toString();
    th.text = header;
    this.header.append(th);
    this.cells.add(cell);
    
    if (this.sorting) {
      th.dataset['sortOrder'] = 'noorder';
      th.onClick.listen(sort);
    }
  }
  
  void sort(MouseEvent e) {
    final Element element = e.target;
    final int cellNum = int.parse(element.dataset['col']);
    
    if (element.dataset['sortOrder'] == 'noorder'
        || element.dataset['sortOrder'] == 'up') {
      // TODO: Reset all cells data-sortOrder
      this.data.sort(this.cells[cellNum].compare);
      this.setData(data);
      element.dataset['sortOrder'] = 'down';
    } else {
      // TODO: Reset all cells data-sortOrder
      data.sort(this.cells[cellNum].reverse);
      this.setData(data);
      element.dataset['sortOrder'] = 'up';
    }
  }
  
  void setData(List<D> objs) {
    this.data = objs;
    this.tbody.children.clear();
    
    for (D obj in objs) {
      final TableRowElement row = new TableRowElement();

      for (Cell c in this.cells) {
        final TableCellElement cell = new TableCellElement();
        cell.append(c.getElement(obj));
        row.append(cell);
      }
      
      this.tbody.append(row);
    }
  }
}

