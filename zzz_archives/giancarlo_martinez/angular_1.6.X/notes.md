###Scope
The controller is injected into the html via the ng-controller attribute and provides scope for its child elements. You can inspect the scope of an element in the console using ng-batarang chrome extension and typing $scope when the element is selected. 

Children controllers inherit from parent controller scope via prototypical inheritance but only if there is not a matching function or variable in the child.
 
 ###Data Binding
 Angular uses 2-way data binding. Using ng-model on an input creates a variable in scope and binds the input's value to it.
 "ng-model='todo'"
 Models can be keys of other models:
 "ng-model='todo.complete'"
 Variables are injected/evaluated using double curly brackets: {{ myVar }}
 
 
 ###Directives
 
 ng-click: triggers function on element click
 ng-hide: evaluates variable or function and hides element if true
 ng-repeat: iterates over an iterable, injecting html block with its own scope
 ng-blur: Only fires when clicking outside of an input
 ng-class: conditionally applies classes
 
 classes can be applied by evaluating with a ternary operator, or comma separated key value pairs where the key is the class and the value is the expression. 
 {"editing-item": editing,
 
 ##Communicating Directives
 
 You can require another directive and interact with it by passing in its controller to the directive's link function.
 The parameters for a link function in a directive are: (scope, element, attrs, ctrl)
 
 
 