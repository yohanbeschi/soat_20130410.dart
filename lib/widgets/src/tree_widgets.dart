part of widgets;

class Tree {
  List<TreeConfig> treeConfigs;
  
  Element tree;
  
  Tree(this.treeConfigs);
  
  Element setData(final List data) {
    var tmpTree = buildOneLevelTree(data, this.treeConfigs);
    
    if (this.tree != null) {
      this.tree.replaceWith(tmpTree);
    }
    
    this.tree = tmpTree;
    
    return this.tree;
  }
  
  void addTo(var selector, [String where = 'afterEnd']) {
    if (this.tree == null) {
      this.tree = new SpanElement();
    }
    
    var element;
    if (selector is String) {
      element = query(selector);
    } else {
      element = selector; 
    }
    
    element.insertAdjacentElement(where, this.tree);
  }
  
  Element buildOneLevelTree(final List data, final List<TreeConfig> treeNodes, [final int depth = 0]) {
    Element tree;
    
    if (data != null && !data.isEmpty) {
      final TreeConfig treeNode = treeNodes[depth];
      
      tree = new UListElement();
        
      for (dynamic element in data) {
        final LIElement li = new LIElement();
        li.text = treeNode.value(element);
        
        if (treeNode.children != null) {
          final UListElement ulChild = buildOneLevelTree(treeNode.children(element), treeNodes, depth + 1);
          
          if (ulChild != null) {
            li.append(ulChild);
          }
        }
        
        tree.append(li);
      }
    }
    
    return tree;
  }
}

typedef dynamic Accessor(dynamic data);

class TreeConfig {
  //---- Data
  Accessor _value;
  Accessor _children;

  TreeConfig(Accessor this._value, [Accessor this._children]);
  
  Accessor get value => _value;
  Accessor get children => _children;
}

