require_relative 'method4'

def test_binary(methods_instance4)
  puts "Test cases for Binary method:"
  puts "Expected: 1001, Actual: #{methods_instance4.binary(9)}"
  puts "Pass: #{methods_instance4.binary(9) == '1001'}"

  puts "Expected: 1111110110, Actual: #{methods_instance4.binary(1022)}"
  puts "Pass: #{methods_instance4.binary(1022) == '1111110110'}"

  begin
    methods_instance4.binary('invalid')
    puts "Pass: false (No error raised)"
  rescue ArgumentError
    puts "Pass: true (ArgumentError raised)"
  end
end

def test_hexadecimal(methods_instance4)
  puts "Test cases for Hexadecimal method:"
  puts "Expected: a, Actual: #{methods_instance4.hexadecimal(10)}"
  puts "Pass: #{methods_instance4.hexadecimal(10) == 'a'}"

  puts "Expected: 1f4, Actual: #{methods_instance4.hexadecimal(500)}"
  puts "Pass: #{methods_instance4.hexadecimal(500) == '1f4'}"

  begin
    methods_instance4.hexadecimal('invalid')
    puts "Pass: false (No error raised)"
  rescue ArgumentError
    puts "Pass: true (ArgumentError raised)"
  end
end

def test_octal(methods_instance4)
  puts "Test cases for Octal method:"
  puts "Expected: 11, Actual: #{methods_instance4.octal(9)}"
  puts "Pass: #{methods_instance4.octal(9) == '11'}"

  puts "Expected: 7642, Actual: #{methods_instance4.octal(4018)}"
  puts "Pass: #{methods_instance4.octal(4018) == '7642'}"

  begin
    methods_instance4.octal('invalid')
    puts "Pass: false (No error raised)"
  rescue ArgumentError
    puts "Pass: true (ArgumentError raised)"
  end
end

def test_ftoc(methods_instance4)
  puts "Test cases for Fahrenheit to Celsius method:"
  puts "Expected: 0, Actual: #{methods_instance4.fToC(32)}"
  puts "Pass: #{(methods_instance4.fToC(32) - 0).abs < 0.01}"

  puts "Expected: 100, Actual: #{methods_instance4.fToC(212)}"
  puts "Pass: #{(methods_instance4.fToC(212) - 100).abs < 0.01}"

  puts "Expected: -40, Actual: #{methods_instance4.fToC(-40)}"
  puts "Pass: #{(methods_instance4.fToC(-40) - -40).abs < 0.01}"
end

def test_max(methods_instance4)
  puts "Test cases for Max method:"
  puts "Expected: 5, Actual: #{methods_instance4.maximum([1, 2, 3, 4, 5])}"
  puts "Pass: #{methods_instance4.maximum([1, 2, 3, 4, 5]) == 5}"

  puts "Expected: 10, Actual: #{methods_instance4.maximum([10, 10, 10])}"
  puts "Pass: #{methods_instance4.maximum([10, 10, 10]) == 10}"

  begin
    methods_instance4.maximum([])
    puts "Pass: false (No error raised)"
  rescue ArgumentError
    puts "Pass: true (ArgumentError raised)"
  end
end

def test_mean(methods_instance4)
  puts "Test cases for Mean method:"
  puts "Expected: 3, Actual: #{methods_instance4.mean([1, 2, 3, 4, 5])}"
  puts "Pass: #{(methods_instance4.mean([1, 2, 3, 4, 5]) - 3).abs < 0.01}"

  puts "Expected: 0, Actual: #{methods_instance4.mean([0, 0, 0, 0])}"
  puts "Pass: #{(methods_instance4.mean([0, 0, 0, 0]) - 0).abs < 0.01}"

  begin
    methods_instance4.mean([])
    puts "Pass: false (No error raised)"
  rescue ArgumentError
    puts "Pass: true (ArgumentError raised)"
  end
end

def test_fib(methods_instance4)
  puts "Test cases for Fibonacci method:"
  puts "Expected: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34], Actual: #{methods_instance4.fibonacci(10)}"
  puts "Pass: #{methods_instance4.fibonacci(10) == [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]}"

  puts "Expected: [0], Actual: #{methods_instance4.fibonacci(1)}"
  puts "Pass: #{methods_instance4.fibonacci(1) == [0]}"

  begin
    methods_instance4.fibonacci(-1)
    puts "Pass: false (No error raised)"
  rescue ArgumentError
    puts "Pass: true (ArgumentError raised)"
  end
end

# Instantiate the methods instances
methods_instance4 = Methods4.new

# Run test cases
test_binary(methods_instance4)
test_hexadecimal(methods_instance4)
test_octal(methods_instance4)
test_ftoc(methods_instance4)
test_max(methods_instance4)
test_mean(methods_instance4)
test_fib(methods_instance4)
