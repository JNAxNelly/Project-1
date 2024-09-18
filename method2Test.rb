require_relative 'method2'

methods = Method2.new

# Test case for logarithm method
def test_logarithm(methods)
  puts "Testing logarithm method"

  result = methods.logarithm(8, 2)
  puts "log(8, 2): Expected: #{Math.log(8, 2)}, Got: #{result}"

  result = methods.logarithm(8, 1)
  puts "log(8, 1): Expected: nil (Error message), Got: #{result}"

  result = methods.logarithm(8, -2)
  puts "log(8, -2): Expected: nil (Error message), Got: #{result}"

  result = methods.logarithm(-8, 2)
  puts "log(-8, 2): Expected: nil (Error message), Got: #{result}"

  puts "Finished testing logarithm method\n\n"
end

# Test case for factorial method
def test_factorial(methods)
  puts "Testing factorial method"

  result = methods.factorial(5)
  puts "factorial(5): Expected: 120, Got: #{result}"

  result = methods.factorial(0)
  puts "factorial(0): Expected: 1, Got: #{result}"

  result = methods.factorial(-1)
  puts "factorial(-1): Expected: nil (Error message), Got: #{result}"

  puts "Finished testing factorial method\n\n"
end

# Test case for percentage method
def test_percentage(methods)
  puts "Testing percentage method"

  result = methods.percentage(50, 100)
  puts "percentage(50, 100): Expected: 50.0, Got: #{result}"

  result = methods.percentage(25, 100)
  puts "percentage(25, 100): Expected: 25.0, Got: #{result}"

  result = methods.percentage(50, 0)
  puts "percentage(50, 0): Expected: nil (Error message), Got: #{result}"

  puts "Finished testing percentage method\n\n"
end

# Test case for median method
def test_median(methods)
  puts "Testing median method"

  result = methods.median([1, 3, 5])
  puts "median([1, 3, 5]): Expected: 3, Got: #{result}"

  result = methods.median([1, 3, 6, 8])
  puts "median([1, 3, 6, 8]): Expected: 4.5, Got: #{result}"

  result = methods.median([])
  puts "median([]): Expected: nil, Got: #{result.inspect}"

  result = methods.median([7])
  puts "median([7]): Expected: 7, Got: #{result}"

  puts "Finished testing median method\n\n"
end

# Test case for generateprime method
def test_generateprime(methods)
  puts "Testing generateprime method"

  methods.generateprime(10)
  expected_output = "2\n3\n5\n7"
  actual_output = File.read("primes.txt").strip
  puts "generateprime(10): Expected:\n#{expected_output}, Got:\n#{actual_output}"

  methods.generateprime(-10)
  expected_output = ""
  actual_output = File.read("primes.txt").strip
  puts "generateprime(-10): Expected: Empty file, Got:\n#{actual_output}"

  puts "Finished testing generateprime method\n\n"
end

# Running all test cases
test_logarithm(methods)
test_factorial(methods)
test_percentage(methods)
test_median(methods)
test_generateprime(methods)