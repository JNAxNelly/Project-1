require 'tk'
require_relative 'Methods1'
require_relative 'Methods3'
require_relative 'method2'
require_relative 'method4'


# Create the main window (root)
root = TkRoot.new { title "Calculator" }

# Create a label to display the input/output
display = TkLabel.new(root) do
  text '0'
  font TkFont.new('times 20 bold')
  relief 'ridge'
  anchor 'e'
  width 20
  pack { padx 10; pady 10 }
end

$current_input = ''

#Operators
OPERATORS = {
  '+' => 1,
  '-' => 1,
  '*' => 2,
  '/' => 2,
  '^' => 3,
  '√' => 4
}

#Instances of method classes that have operations
methods_instance3 = Methods3.new
methods_instance1 = Methods1.new
methods_instance2 = Method2.new
methods_instance4 = Methods4.new

#Updates calculator display
def update_display(new_value, display)
  $current_input += new_value
  display.text = $current_input
end

#Clears display
def clear_display(display)
  $current_input = ''
  display.text = '0'
end

#Convert to postfix notation 
def to_postfix(expression)
  output = []
  operator_stack = []
  tokens = expression.scan(/\d+\.?\d*|\+|\-|\*|\/|\^|\(|\)|√/) # Updated the tokenization
  
  tokens.each_with_index do |token, index|
    if token =~ /\d/ # Match numbers
      output << token
    elsif token == '('
      operator_stack.push(token)
    elsif token == ')'
      while operator_stack.last != '('
        output << operator_stack.pop
      end
      operator_stack.pop
    elsif OPERATORS[token]
      # Handle negative number cases:
      # If token is '-' and is the first character or follows an operator or '(', it's a negative sign
      if token == '-' && (index == 0 || tokens[index - 1] =~ /[\+\-\*\/\(]/)
        output << '0' # Insert a '0' to make subtraction work (e.g., 0 - 3 instead of just -3)
        operator_stack.push(token)
      else
        while !operator_stack.empty? && OPERATORS[operator_stack.last] && OPERATORS[operator_stack.last] >= OPERATORS[token]
          output << operator_stack.pop
        end
        operator_stack.push(token)
      end
    end
  end
  
  #Pop all remaining ops from stack and add to output
  while !operator_stack.empty?
    output << operator_stack.pop
  end
  
  output
end

#Function to evaluate postfix
def evaluate_postfix(postfix, methods_instance3)
  stack = []

  postfix.each do |token|
    if token =~ /-?\d/
      stack.push(token.to_f)
    elsif token == '+'
      b = stack.pop
      a = stack.pop
      stack.push(a + b)
    elsif token == '-'
      b = stack.pop
      a = stack.pop
      stack.push(a - b)
    elsif token == '*'
      b = stack.pop
      a = stack.pop
      stack.push(a * b)
    elsif token == '/'
      b = stack.pop
      a = stack.pop
      if b == 0
        return Float::INFINITY
      else
        stack.push(a / b)
      end
    elsif token == '^'
      b = stack.pop
      a = stack.pop
      stack.push(a**b)
    end
  end

  stack.pop
end

#Main function to evaluate the input and update display
def evaluate_expression(display, methods_instance3)
  begin
    postfix = to_postfix($current_input)
    result = evaluate_postfix(postfix, methods_instance3)

    if result == Float::INFINITY || result.nan?
      display.text = 'Error: Division by Zero'
      $current_input = ''
    else
      display.text = result.to_s
      $current_input = result.to_s
    end
  rescue
    display.text = 'Error'
    $current_input = ''
  end
end

#Popup Block ---------------------------------------------------------------------------------------
#Handles popups for buttons that require data you need to input
def handle_median_to_file(methods_instance2, data_entry, display, popup)
  data = data_entry.value.split(',').map(&:to_f)
  result = methods_instance2.median(data)
  display.text = result.to_s
  
  popup.destroy
end

def median_popup(methods_instance2, display)
  popup = TkToplevel.new { title "Median Calculator" }

  TkLabel.new(popup) do
    text 'Enter numbers (comma-separated):'
    pack { padx 10; pady 5 }
  end

  data_entry = TkEntry.new(popup) do
    width 30
    pack { padx 10; pady 5 }
  end

  TkButton.new(popup) do
    text 'Calculate Median'
    command { handle_median_to_file(methods_instance2, data_entry, display, popup) }
    pack { padx 10; pady 10 }
  end
end

def handle_log(methods_instance2, base_entry, number_entry, display, popup)
  base = base_entry.value.to_f
  number = number_entry.value.to_f

  result = methods_instance2.logarithm(base, number)
  display.text = result.to_s
  
  popup.destroy
end

def log_popup(methods_instance2, display)
  popup = TkToplevel.new { title "Logarithm Calculator" }

  TkLabel.new(popup) do
    text 'Enter number:'
    pack { padx 10; pady 5 }
  end

  base_entry = TkEntry.new(popup) do
    width 10
    pack { padx 10; pady 5 }
  end

  TkLabel.new(popup) do
    text 'Enter base:'
    pack { padx 10; pady 5 }
  end

  number_entry = TkEntry.new(popup) do
    width 10
    pack { padx 10; pady 5 }
  end

  TkButton.new(popup) do
    text 'Calculate Log'
    command { handle_log(methods_instance2, base_entry, number_entry, display, popup) }
    pack { padx 10; pady 10 }
  end
end

def handle_percent(methods_instance2, base_entry, percent_entry, display, popup)
  base = base_entry.value.to_f
  percent = percent_entry.value.to_f

  result = methods_instance2.percentage(base, percent)
  display.text = result.to_s + '%'
  
  popup.destroy
end

def percent_popup(methods_instance2, display)
  popup = TkToplevel.new { title "Percentage Calculator" }

  TkLabel.new(popup) do
    text 'Enter numerator:'
    pack { padx 10; pady 5 }
  end

  base_entry = TkEntry.new(popup) do
    width 10
    pack { padx 10; pady 5 }
  end

  TkLabel.new(popup) do
    text 'Enter denominator:'
    pack { padx 10; pady 5 }
  end

  percent_entry = TkEntry.new(popup) do
    width 10
    pack { padx 10; pady 5 }
  end

  TkButton.new(popup) do
    text 'Calculate Percent'
    command { handle_percent(methods_instance2, base_entry, percent_entry, display, popup) }
    pack { padx 10; pady 10 }
  end
end

def handle_odd_to_file(methods_instance3, range_start, range_end, display)
  start_val = range_start.value.to_i
  end_val = range_end.value.to_i

  if start_val >= end_val
    display.text = "Invalid Range"
  else
    methods_instance3.generateOddToFile([start_val, end_val], "odd_numbers.txt")
    display.text = "Odd numbers saved to file."
  end
end

def odd_popup(methods_instance3, display)
  popup = TkToplevel.new { title "Odd Number Generator" }

  range_label = TkLabel.new(popup) do
    text 'Enter range for odd numbers:'
    font TkFont.new('times 15 bold')
    pack { padx 10; pady 5 }
  end

  range_start = TkEntry.new(popup) do
    width 10
    pack { padx 10; pady 5 }
  end

  range_end = TkEntry.new(popup) do
    width 10
    pack { padx 10; pady 5 }
  end

  TkButton.new(popup) do
    text 'Generate Odd Numbers'
    command { handle_odd_to_file(methods_instance3, range_start, range_end, display) }
    pack { padx 10; pady 10 }
  end
end
def handle_Even_range_to_file(methods_instance1, range_start, range_end, display)
  start_val = range_start.value.to_i
  end_val = range_end.value.to_i

  if start_val >= end_val
    display.text = "Invalid Range"
  else
    methods_instance1.genEven([start_val, end_val])
    display.text = "Range saved to file."

  end
end

def even_popup(methods_instance1, display)
  popup = TkToplevel.new { title "Even Number Generator" }

  range_label = TkLabel.new(popup) do
    text 'Enter range for Even numbers:'
    font TkFont.new('times 15 bold')
    pack { padx 10; pady 5 }
  end

  range_start = TkEntry.new(popup) do
    width 10
    pack { padx 10; pady 5 }
  end

  range_end = TkEntry.new(popup) do
    width 10
    pack { padx 10; pady 5 }
  end

  TkButton.new(popup) do
    text 'Generate Even Numbers'
    command {handle_Even_range_to_file(methods_instance1, range_start, range_end, display) }
    pack { padx 10; pady 10 }
  end
end

def prime_popup(methods_instance3, display)
  popup = TkToplevel.new { title "Prime Number Checker" }

  prime_label = TkLabel.new(popup) do
    text 'Enter a number to check if it is prime:'
    font TkFont.new('times 15 bold')
    pack { padx 10; pady 5 }
  end

  prime_input = TkEntry.new(popup) do
    width 10
    pack { padx 10; pady 5 }
  end

  TkButton.new(popup) do
    text 'Check Prime'
    command {
      number = prime_input.value.to_i
      if methods_instance3.isPrime?(number)
        display.text = "#{number} is Prime"
      else
        display.text = "#{number} is not Prime"
      end
    }
    pack { padx 10; pady 10 }
  end
end

def minimum_popup(methods_instance3, display)
  popup = TkToplevel.new { title "Minimum Calculator" }

  min_label = TkLabel.new(popup) do
    text 'Enter a list of numbers (comma-separated):'
    font TkFont.new('times 15 bold')
    pack { padx 10; pady 5 }
  end

  min_input = TkEntry.new(popup) do
    width 30
    pack { padx 10; pady 5 }
  end

  TkButton.new(popup) do
    text 'Calculate Minimum'
    command {
      numbers = min_input.value.split(',').map(&:to_i)
      result = methods_instance3.minimum(numbers)
      display.text = "Minimum: #{result}"
    }
    pack { padx 10; pady 10 }
  end
end
def ExponentMethod(methods_instance1, display)
  popup = TkToplevel.new { title "Exponent Calculator" }

  exp_label = TkLabel.new(popup) do
    text 'Enter a base and an exponent (comma-separated):'
    font TkFont.new('times 15 bold')
    pack { padx 10; pady 5 }
  end

  exp_input = TkEntry.new(popup) do
    width 30
    pack { padx 10; pady 5 }
  end

  TkButton.new(popup) do
    text 'Calculate Exponent'
    command {
      begin
        # Split input and map to integers
        data = exp_input.value.split(',').map(&:strip)
        
        # Validate input: check if exactly two values are given and they are numeric
        if data.size != 2 || !is_numeric?(data[0]) || !is_numeric?(data[1])
          raise ArgumentError, "Invalid input"
        end
        
        base = data[0].to_f
        exponent = data[1].to_i

        # Perform the exponentiation
        result = methods_instance1.exponent(base, exponent)
        display.text = "Exponent: #{result}"

      rescue ArgumentError => e
        display.text = "Invalid input"
      rescue => e
        display.text = "Invalid input"
      end
    }
    pack { padx 10; pady 10 }
  end
end

# Helper function to check if a string can be converted to a number
def is_numeric?(str)
  true if Float(str) rescue false
end

# Method to handle mode input and display result
def handle_mode_input(methods_instance3, mode_input, display)
  data = mode_input.value.split(',').map(&:to_i) # Convert the input to an array of integers
  if data.empty?
    display.text = "Invalid Input"
  else
    result = methods_instance3.mode(data)
    display.text = "Mode: #{result}"
  end
end

# Popup for mode calculation
def mode_popup(methods_instance3, display)
  popup = TkToplevel.new { title "Mode Calculator" }

  mode_label = TkLabel.new(popup) do
    text 'Enter a list of numbers (comma-separated):'
    font TkFont.new('times 15 bold')
    pack { padx 10; pady 5 }
  end

  # Input field for the list of numbers
  mode_input = TkEntry.new(popup) do
    width 30
    pack { padx 10; pady 5 }
  end

  # Button to calculate the mode
  TkButton.new(popup) do
    text 'Calculate Mode'
    command { handle_mode_input(methods_instance3, mode_input, display) }
    pack { padx 10; pady 10 }
  end
end

def handle_Square_range_to_file(methods_instance1, range_start, range_end, display)
  start_val = range_start.value.to_i
  end_val = range_end.value.to_i

  if start_val >= end_val
    display.text = "Invalid Range"
  else
    methods_instance1.genSqrd([start_val, end_val])
    display.text = "Range saved to file."

  end
end
def sqr_popup(methods_instance1, display)
  popup = TkToplevel.new { title "Square Number Generator" }

  range_label = TkLabel.new(popup) do
    text 'Enter range for square numbers:'
    font TkFont.new('times 15 bold')
    pack { padx 10; pady 5 }
  end

  range_start = TkEntry.new(popup) do
    width 10
    pack { padx 10; pady 5 }
  end

  range_end = TkEntry.new(popup) do
    width 10
    pack { padx 10; pady 5 }
  end

  TkButton.new(popup) do
    text 'Generate square Numbers'
    command {handle_Square_range_to_file(methods_instance1, range_start, range_end, display) }
    pack { padx 10; pady 10 }
  end
end

#Method mean for the separate GUI to take in an array
def mean_popup(methods_instance4, display)
  popup = TkToplevel.new { title "Mean Number Calculation"}
  #label to prompt user for entering array
  arr_label = TkLabel.new(popup) do
    text 'Enter array of numbers, separated by commas'
    font TkFont.new('times 15 bold')
    pack { padx 10; pady 5 }
  end
  #input box for array
  arr_entry = TkEntry.new(popup) do
    width 20
    pack { padx 10; pady 5 }
  end
  #button to call method and print to main calculator gui
  TkButton.new(popup) do
    text 'Calculate Mean'
    command do
      input = arr_entry.value
      number_array = input.split(',').map(&:strip).map(&:to_f)

      mean_result = methods_instance4.mean(number_array)

      display.text = mean_result.to_s
      $current_input = mean_result.to_s
    end
    pack { padx 15; pady 10 }
  end
end

#Method max for the separate GUI to take in an array
def max_popup(methods_instance4, display)
  popup = TkToplevel.new { title "Max Number Calculation"}
  #label to prompt user for entering array
  arr_label = TkLabel.new(popup) do
    text 'Enter array of numbers, separated by commas'
    font TkFont.new('times 15 bold')
    pack { padx 10; pady 5 }
  end
  #input box for array
  arr_entry = TkEntry.new(popup) do
    width 20
    pack { padx 10; pady 5 }
  end
  #button to call method and print to main calculator gui
  TkButton.new(popup) do
    text 'Calculate Max'
    command do
      input = arr_entry.value
      number_array = input.split(',').map(&:strip).map(&:to_f)

      max_result = methods_instance4.maximum(number_array)
      display.text = "Maximum #{max_result}"
      $current_input = max_result.to_s
    end
    pack { padx 15; pady 10 }
  end
end
#Method fibonacci for separate GUI to prompt limit
def fib_popup(methods_instance4, display)
  popup = TkToplevel.new { title "Fibonacci Generator"}
  #label to ask user for limit to input
  fib_label = TkLabel.new(popup) do
    text 'Enter limit'
    font TkFont.new('times 15 bold')
    pack { padx 10; pady 5 }
  end
 #box to input limit to
  limit_entry = TkEntry.new(popup) do
    width 10
    pack { padx 10; pady 5}
  end
 #Prints a message to calculator to confirm printed to file
 TkButton.new(popup) do
   text 'Generate Fibonacci'
   command do
     input = limit_entry.value.to_i
     if input > 0
       result = methods_instance4.fibonacci(input)
       display.text = "Fib printed to file"
     else
      display.text = "Error printing fib"
     end
   end
   pack { padx 10; pady 10}
 end
end

#End of popups block---------------------------------------------------------------------------------------

#Contains the buttons that will be on the calculator
button_frame = TkFrame.new(root).pack
buttons = [
  ['(', ')', '√', '/'],
  ['7', '8', '9', '*'],
  ['4', '5', '6', '-'],
  ['1', '2', '3', '+'],
  ['C', '0', '=', '^'],
  ['sin', 'cos', 'tan','mean'],
  ['genOdd','genEven','Neg','median'],
  ['genSqrd','genPrime','genFib','mode'],
  ['log','max','min','binary'],
  ['!','%','cbrt','octal',],
  ['hexa','FtoC']
]

#Genertes the button on the GUI
buttons.each_with_index do |row, row_index|
  row.each_with_index do |button_text, col_index|
    button = TkButton.new(button_frame) do
      text button_text
      width 5
      height 2
      font TkFont.new('times 15 bold')
      grid('row' => row_index, 'column' => col_index, 'padx' => 5, 'pady' => 5)

      #When button is pressed, handle corresponding functionality
      command do
        case button_text
        when 'C'
          clear_display(display)
        when '='
          evaluate_expression(display, methods_instance3)
        when 'Neg'
          if !$current_input.empty?
            if $current_input[-1] =~ /[\+\-\*\/]/
              update_display('-', display)
            elsif $current_input[-1] != '('
              $current_input = "-#{$current_input}" unless $current_input.start_with?('-')
              display.text = $current_input
            end
          else
            update_display('-', display)
          end
        when 'genOdd'
          odd_popup(methods_instance3, display)
        when 'sin'
          result = methods_instance3.sin($current_input.to_f)
          display.text = result.to_s
          $current_input = result.to_s
        when 'cos'
          result = methods_instance3.cos($current_input.to_f)
          display.text = result.to_s
          $current_input = result.to_s
        when 'tan'
          result = methods_instance3.tan($current_input.to_f)
          display.text = result.to_s
          $current_input = result.to_s
        when 'abs'
          result = methods_instance1.absolute($current_input.to_f)
          display.text = result.to_s
          $current_input = result.to_s
        when 'cbrt'
          result = methods_instance1.cbrt($current_input.to_f)
          display.text = result.to_s
          $current_input = result.to_s
        when '√'
          result = methods_instance1.sqrt($current_input.to_f)
          display.text = result.to_s
          $current_input = result.to_s
        when 'genEven'
          even_popup(methods_instance1, display)
        when 'genSqrd'
          sqr_popup(methods_instance1, display)
        when '^'
          ExponentMethod(methods_instance1, display)
        when 'log'
          log_popup(methods_instance2, display)
        when '!'
          n = $current_input.to_i
          result = methods_instance2.factorial(n)
          display.text = result.to_s
          $current_input = result.to_s
        when '%'
          percent_popup(methods_instance2, display)
        when 'median'
          median_popup(methods_instance2, display)
        when 'genPrime'
          n = $current_input.to_i
          methods_instance2.generateprime(n)
          display.text = "Primes saved"
          $current_input = ''
        when 'min'
          minimum_popup(methods_instance3, display)
        when 'isPrime'
          prime_popup(methods_instance3, display)
        when 'mode'
          mode_popup(methods_instance3, display)
        when 'binary'
          binary = methods_instance4.binary($current_input.to_i)
          display.text = binary
          $current_input = display.text
        when 'octal'
          octal = methods_instance4.octal($current_input.to_i)
          display.text = octal
          $current_input = display.text
        when 'hexa'
          hexa = methods_instance4.hexadecimal($current_input.to_i)
          display.text = hexa
          $current_input = display.text
        when 'mean'
          mean_popup(methods_instance4, display)
        when 'max'
          max_popup(methods_instance4, display)
        when 'genFib'
          fib_popup(methods_instance4, display)
        when 'FtoC'
          celsius = methods_instance4.fToC($current_input.to_i)
          display.text = "#{celsius} C"
          $current_input = display.text
        else
          update_display(button_text, display)
        end
      end
    end
  end
end

Tk.mainloop