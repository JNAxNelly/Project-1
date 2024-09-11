# This file contains the methods for the third set of functions in the calculator.
class Calculator
  # Category 1
  def sin(n)
    Math.sin(n)
  end

  def cos(n)
    Math.cos(n)
  end

  def tan(n)
    Math.tan(n)
  end

  # Category 2
  def isPrime?(n)
    if n <= 1
      return false
    end

    if n == 2
      return true
    end

    if n % 2 == 0
      return false
    end

    i = 3
    while i <= Math.sqrt(n)
      if n % i == 0
        return false
      end
      i += 2
    end

    return true
  end

  def minimum(data)
    if data.length == 0
      puts "Error: Empty data."
      return nil
    end

    min = data[0]
    i = 1
    while i < data.length
      if data[i] < min
        min = data[i]
      end
      i += 1
    end
    min
  end

  def generateOddToFile(range, filename)
    start_num = range[0]
    end_num = range[1]

    if start_num >= end_num
     puts "Invalid range."
      return
    end

    File.open(filename, "w") do |file|  # Block starts here
      i = start_num
      while i <= end_num
        if i % 2 != 0 
          file.puts i  # Writes odd number to the file
        end
        i += 1 
      end
    end  # Block ends here, file is automatically closed
  end 

  def mode(data)
    if data.length == 0
      puts "Error: Empty data."
      return nil
    end
 
    frequency = {}
  
    i = 0
    while i < data.length
      element = data[i]

      if frequency[element]
        frequency[element] += 1
      else
        frequency[element] = 1
      end
    
      i += 1
    end

    keys = frequency.keys
    mode_value = keys[0]
    max_occurrences = frequency[keys[0]]

    j = 1
    while j < keys.length
      key = keys[j]
      if frequency[key] > max_occurrences
        max_occurrences = frequency[key]
        mode_value = key
      end
      j += 1
    end
  
    return mode_value
  end
end
