###Scope
The controller is injected into the html via the ng-controller attribute and provides scope for its child elements. You can inspect the scope of an element in the console using ng-batarang chrome extension and typing $scope when the element is selected. 

Children controllers inherit from parent controller scope via prototypical inheritance but only if there is not a matching function or variable in the child.
 
 ###Data Binding
 Angular uses 2-way data binding. Using ng-model on an input creates a variable in scope and binds the input's value to it.
 "ng-model='todo'"
 Models can be keys of other models:
 "ng-model='todo.complete'"
 Variables are injected/evaluated using double curly brackets: {{ myVar }}