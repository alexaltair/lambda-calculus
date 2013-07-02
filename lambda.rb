# First assume all the variables are unique, later check for that by converting them into de Bruijn notation
def classical_to_prefix(string)
  # Convert from string like '\x.x(\y.zy \a.ab)' to string like '*\x.x*\y.*zy\a.*ab'.
  # => prefix_array
end

def prefix_string_to_array(prefix_string)
#   Convert the string into an array of single characters.
#   Create an array for the whole parsed expression
#   Start parsing, one character at a time.
#   Use recursion.
#   Return an array which is the parsed lambda expression, arrays within arrays.

# \x.x
# [:x, [:x]]

# *xy
# [:*, [:x], [:y]]

# xyz => **xyz


# a(x) => [:x]
# a(*XY) => [:*, a(X), a(Y)]
# a(\x.A) => [:x, a(A)]

  lambda_array = []
  input_string.split("").each do |char|
    if char == '*'
      # 
    elsif char == '/'
      # This is the beginning of a lambda binding.
    else
      # This is a variable.
    end
  end

#   => lambda_array
end


# Lazy evaluation versus eager evaluation?
def evaluate(lambda_array)
# Look for beta reductions breadth-first.
# For each item in the array
#   If it's not a beta reduction
#     Look at the next in the array
#   Else
#     perform the beta reduction
# Take the second argument and put it into the holes of the first argument
# => lambda_array
end


def beta_reduce(application_array)
  # Take a single lambda application of the form [:*, [L], [M]] and return a lambda array of the form [N]
  # => lambda_array
end


def array_to_prefix_string(lambda_array)
  lambda_string = ""

  if lambda_array[0] == :*
    lambda_array.shift
    lambda_string << '*' + array_to_prefix_string(lambda_array[0]) + array_to_prefix_string(lambda_array[1])
  else
    var = lambda_array[0]
    lambda_array.shift
    lambda_string << '/' + var + '.' + lambda_array[1]
  end
    
end