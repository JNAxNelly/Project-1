require_relative 'Methods1'

methods = Methods1.new

# Test Cases for sqrt
puts "Test Case for sqrt:"
puts methods.sqrt(9) == 3.0            # sqrt(9) should return 3.0
puts methods.sqrt(16) == 4.0           # sqrt(16) should return 4.0
puts methods.sqrt(2).round(4) == 1.4142  # sqrt(2) should return approximately 1.4142

# Test Cases for cbrt
puts "Test Case for cbrt:"
puts methods.cbrt(27) == 3.0           # cbrt(27) should return 3.0
puts methods.cbrt(64) == 4.0           # cbrt(64) should return 4.0
puts methods.cbrt(2).round(4) == 1.2599  # cbrt(2) should return approximately 1.2599

# Test Cases for exponent
puts "Test Case for exponent:"
puts methods.exponent(2, 3) == 8.0     # 2^3 should return 8
puts methods.exponent(5, 0) == 1.0     # 5^0 should return 1
puts methods.exponent(2, -3).round(4) == 0.125  # 2^-3 should return approximately 0.125

# Test Cases for genEven
puts "Test Case for genEven:"
methods.genEven([1, 10])                # Should generate even numbers from 1 to 10
even_file_content = File.read('even_numbers.txt').strip
puts even_file_content == "2\n4\n6\n8\n10"  # Check if file content matches expected even numbers
begin
  methods.genEven([10, 1])              # Should raise ArgumentError for invalid range
rescue ArgumentError => e
  puts e.message == "Invalid range: The end of the range (1) is smaller than the start (10)."
end

# Test Cases for absolute
puts "Test Case for absolute:"
puts methods.absolute(-5) == 5          # absolute(-5) should return 5
puts methods.absolute(3) == 3           # absolute(3) should return 3
puts methods.absolute(0) == 0           # absolute(0) should return 0

# Test Cases for genSqrd
puts "Test Case for genSqrd:"
methods.genSqrd([1, 5])                 # Should generate square numbers from 1 to 5
square_file_content = File.read('square_numbers.txt').strip
puts square_file_content == "1\n4\n9\n16\n25"  # Check if file content matches expected square numbers
begin
  methods.genSqrd([5, 1])               # Should raise ArgumentError for invalid range
rescue ArgumentError => e
  puts e.message == "Invalid range: The end of the range (1) is smaller than the start (5)."
end
Ma
