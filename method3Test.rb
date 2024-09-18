require_relative 'Methods3'

methods = Methods3.new

# Test Cases for sin
puts "Test Case for sin:"
puts methods.sin(0) == 0.0         # sin(0) should return 0.0
puts methods.sin(Math::PI/2) == 1  # sin(pi/2) should return 1.0

# Test Cases for cos
puts "Test Case for cos:"
puts methods.cos(0) == 1.0         # cos(0) should return 1.0
puts methods.cos(Math::PI) == -1.0 # cos(pi) should return -1.0

# Test Cases for tan
puts "Test Case for tan:"
puts methods.tan(0) == 0.0         # tan(0) should return 0.0
puts methods.tan(Math::PI/4).round(4) == 1.0 # tan(pi/4) should return 1.0 (approximate)

# Test Cases for isPrime?
puts "Test Case for isPrime?:"
puts methods.isPrime?(2) == true   # 2 is prime
puts methods.isPrime?(3) == true   # 3 is prime
puts methods.isPrime?(4) == false  # 4 is not prime
puts methods.isPrime?(17) == true  # 17 is prime
puts methods.isPrime?(18) == false # 18 is not prime

# Test Cases for minimum
puts "Test Case for minimum:"
puts methods.minimum([3, 1, 4, 1, 5, 9]) == 1   # min in the list is 1
puts methods.minimum([10, 20, 30]) == 10        # min is 10
puts methods.minimum([10]) == 10                # single element
puts methods.minimum([]).nil?                   # empty array should return nil

# Test Cases for generateOddToFile
puts "Test Case for generateOddToFile:"
methods.generateOddToFile([1, 10], 'test_odd.txt')  # Should generate a file with odd numbers from 1 to 10
odd_file_content = File.read('test_odd.txt').strip
puts odd_file_content == "1 3 5 7 9"    # Test the content of the file

# Test Cases for mode
puts "Test Case for mode:"
puts methods.mode([1, 2, 3, 3, 4]) == 3  # mode is 3
puts methods.mode([4, 4, 2, 2, 1]) == 4  # both 4 and 2 appear twice, but 4 comes first
puts methods.mode([1, 1, 2, 2, 3, 3]) == 1  # all elements have equal frequency, returns the first one
puts methods.mode([]).nil?              # empty array should return nil
