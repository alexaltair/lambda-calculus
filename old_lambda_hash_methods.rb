# First assume all the variables are unique, later check for that by converting them into de Bruijn notation
def classical_to_prefix(string)
  # Convert from string like '\x.x(\y.zy \a.ab)' to string like '*\x.x*\y.*zy\a.*ab'.
  # => prefix_array
end

# ----------------------------------- Broken -------------------------------------------
def prefix_string_to_tree(prefix, two_expressions=false)
  # Can take a string or a character array.
  array = prefix.split('') if prefix.is_a?(String)
  array ||= prefix
  first = array[0]
  case first
  when '*'
    # This is a composition, also called application
    array.shift
    part1, part2 = prefix_string_to_tree(array, true)
    if two_expressions
      part2, remainder = prefix_string_to_tree(part2, true)
      return {:* => [ part1, part2 ]}, remainder
    else
      return {:* => [ part1, part2 ]}
    end
  when '\\'
    # This is the beginning of a lambda binding.
    if array[2] == '.' && !(['\\', '.', '*'].include? array[1])
      bound_var = array[1].to_sym
      array.shift(3)
      if two_expressions
        rest, second = prefix_string_to_tree(array, true)
        return {bound_var => rest}, second
      else
        rest = prefix_string_to_tree(array)
        return {bound_var => rest}
      end
    else
      raise "Parse error: lambda binding improperly formatted."
    end
  else
    # This is a variable.
    if two_expressions
      array.shift
      return first.to_sym, prefix_string_to_tree(array)
    else
      return first.to_sym
      # unless (array.length > 1)
      #   return first.to_sym
      # else
      #   raise "Parse error: string extends beyond closed scope."
      # end
    end
  end

end

# p "Enter lambda expression"
# input = gets.chomp
# prefix_string_to_tree(input)

# p prefix_string_to_tree('**xxy')


# Does the work of beta reduction, but requires the parts be specified.
def substitute(expression, symbol, replacement)
  raise "Type error: second argument not a symbol." if !symbol.is_a?(Symbol)
  if expression.is_a?(Symbol)
    if expression == symbol
      return replacement
    else
      return expression
    end
  elsif expression.is_a?(Hash)
    key = expression.keys[0]
    value = expression.values[0]
    if key == :*
      return {key => [substitute(value[0], symbol, replacement), substitute(value[1], symbol, replacement)]}
    else
      return {key => substitute(value, symbol, replacement)}
    end
  else raise "Type error: first argument not a valid lambda expression."
  end
end


# Does beta reduciton through substitute() if expression is of the form {:* => [{:sym => L}, M]}.
# => lambda_tree
def beta_reduce(lambda_expression)
  is_Hash = lambda_expression.is_a?(Hash)
  is_sym = lambda_expression.is_a?(Symbol)

  if is_Hash
    is_composition = ( lambda_expression.keys[0] == :* )
    first = lambda_expression.values[0][0]
    second = lambda_expression.values[0][1]
    first_is_lambda_binding = first.is_a?(Hash) && (first.keys[0] != :*)
  elsif is_sym
    return lambda_expression
  else raise "Type error: invalid lambda expression."
  end

  if is_Hash && is_composition && first_is_lambda_binding
    substitute(first.values[0], first.keys[0], second)
  else
    lambda_expression
  end
end


# Lazy evaluation versus eager evaluation?
def evaluate(tree)
# Look for beta reductions breadth-first.
# For each item in the array
#   If it's not a beta reduction
#     Look at the next in the array
#   Else
#     perform the beta reduction
# Take the second argument and put it into the holes of the first argument
# => tree
end


def tree_to_prefix_string(tree)
  if tree.is_a?(Symbol)
    return tree.to_s
  elsif tree.is_a?(Hash)
    first = tree.keys[0].to_s
    rest = tree.values[0]
    if first == '*'
      return first + tree_to_prefix_string(rest[0]) + tree_to_prefix_string(rest[1])
    else
      return "\\" + first + '.' + tree_to_prefix_string(rest)
    end
  else raise "Type error: invalid lambda expression."
  end
end


# Takes a string or char array in prefix notation and turns it into infix notation.
# Fails to correctly parenthesize left abstractions; (\x.xy)\a.bb
def tree_to_classical(tree)
  if tree.is_a?(Symbol)
    return tree.to_s
  elsif tree.is_a?(Hash)
    operator = tree.keys[0]
    rest = tree.values[0]
    if operator = :*
      return "#{rest[0]}(#{rest[1]})"
    else
      return "\\#{first}.#{tree_to_classical(rest)}"
    end
  else raise "Type error: invalid lambda expression."
  end
end



# Runs a block on every leaf in the tree.
def each_leaf(tree)

end