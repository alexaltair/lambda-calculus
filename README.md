lambda-calculus
===============

Lambda expressions are a class. Their attributes depend on which kind they are, as defined by the following code snippet from LambdaExpression.rb;

```ruby
case args.length
when 1
  @kind = :variable
  @value = node_value
when 2
  @kind = :abstraction
  @bound_var = node_value
  @body = child1
when 3
  @kind = :application
  @function = child1
  @argument = child2
```

`LambdaExpression.new()` can take a ton of kinds of arguments. Symbols are preferred to strings. The first defines what kind of expression it is, and can be a symbol or string. Second and third arguments can be symbols, strings, or LambdaExpressions. Some valid examples are shown below;

This will become a variable;
```ruby
LambdaExpression.new(:x)
```
These will become abstractions;
```ruby
LambdaExpression.new(:x, :x)
LambdaExpression.new('x', 'x')
LambdaExpression.new(:x, 'xy')
```
These will become applications;
```ruby
LambdaExpression.new(:*, :x, :y)
LambdaExpression.new('*', 'x', 'y')
LambdaExpression.new
```
These will be parsed as strings
```ruby
LambdaExpression.new('x')
LambdaExpression.new('xy')
LambdaExpression.new('(\x.xy)\a.bb')
LambdaExpression.new('\x.xy')
```