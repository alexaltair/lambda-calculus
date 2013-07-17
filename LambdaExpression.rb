# Finds the matching close parent. Assumes that the opening paren is NOT part of the string; assumes 'blah)' rather than '(blah)'.
def close_paren_index(string)
  array = string.split('')
  depth = 1
  index = 0
  array.each_with_index do |char, index|
    if char == ')'
      depth -= 1
      return index if depth == 0
    elsif char == '('
      depth += 1
    end
  end
  raise "Mismatching parentheses."
end

# Takes a string like 'ad(asdf)adf(a)(as(asdf)asd)sf()' and returns an array like ['ad', 'asdf', 'adf', 'a', 'as(asdf)asd', 'sf', ''].
def group_by_parens(string)
  array = []
  while string.length > 0
    if string[0] == '('
      # ---------------------------
    else
      string.index('(') # ---------
    end
  end
  array
end

class LambdaExpression

  # Change the setters so that attributes cannot be changed to make a meaningless lambda expression.
  attr_accessor :kind, :value, :bound_var, :body, :function, :argument

  def initialize(*args)
    node_value, child1, child2 = args

    raise ArgumentError, "The empty string is not a valid lambda expression." if node_value.nil?
    if child1.nil? && child2.nil?
      unless node_value == :*
        @kind = :variable
        @value = node_value
      else
        raise ArgumentError, "Variable cannot be named *; or application requires two arguments."
      end
    elsif child2.nil?
      unless node_value == :*
        @kind = :abstraction
        @bound_var = node_value
        @body = LambdaExpression.new(child1)
      else
        raise ArgumentError, "Variable cannot be named *; or application requires two arguments."
      end
    else
      unless node_value != :*
        unless child1 == :* || child2 == :*
          @kind = :application
          @function = LambdaExpression.new(child1)
          @argument = LambdaExpression.new(child2)
        else
          raise ArgumentError, "Variable cannot be named *."
        end
      else
        raise ArgumentError, "Application should be denoted by a *; or too many arguments for an abstraction or variable."
      end
    end
  end

  def to_s
    case self.kind
    when :variable then self.value.to_s
    when :abstraction then "\\#{self.bound_var}.#{self.body}"
    when :application
      if self.argument.kind == :variable
        "#{self.function}#{self.argument}"
      else
        "#{self.function}(#{self.argument})"
      end
    end
  end

  def string_to_lambda(string)
    
  end

  def beta_reduction(expression)
  end

end


# test = LambdaExpression.new(:x)              # x
# test = LambdaExpression.new(:x, :x)          # \x.x
# test = LambdaExpression.new(:*, :x, :y)      # xy
# test2 = LambdaExpression.new(:x, test)       # \x.xy
# test = LambdaExpression.new(:*, test, test2) # xy(\x.xy)

# puts test
# puts "kind: #{test.kind}"
# puts "bound_var: #{test.bound_var}"
# puts "body: #{test.body}"
# puts "function: #{test.function}"
# puts "argument: #{test.argument}"