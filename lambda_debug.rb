def prefix_string_to_tree(prefix, two_expressions=false)
  # Can take a string, symbol, or character array.
  if prefix.is_a?(String)
    array = prefix.split('')
  elsif prefix.is_a?(Symbol)
    array = [prefix]
  else
    array = prefix
  end
  p array # <---------------------------------
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

p prefix_string_to_tree('**xyy')