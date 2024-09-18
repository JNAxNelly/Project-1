require 'tk'
require_relative 'method4'
require_relative 'Methods3'

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

OPERATORS = {
  '+' => 1,
  '-' => 1,
  '*' => 2,
  '/' => 2,
  '^' => 3,
  '√' => 4
}

methods_instance = Methods3.new
methods_instance4 = Methods4.new

def update_display(new_value, display)
  $current_input += new_value
  display.text = $current_input
end

def clear_display(display)
  $current_input = ''
  display.text = '0'
end

def to_postfix(expression)
  output = []
  operator_stack = []
  tokens = expression.scan(/-?\d+\.?\d*|\+|\-|\*|\/|\^|\(|\)|√/)

  tokens.each_with_index do |token, index|
    if token =~ /-?\d/
      output << token
    elsif token == '('
      operator_stack.push(token)
    elsif token == ')'
      while operator_stack.last != '('
        output << operator_stack.pop
      end
      operator_stack.pop
    elsif OPERATORS[token]
      while !operator_stack.empty? && OPERATORS[operator_stack.last] && OPERATORS[operator_stack.last] >= OPERATORS[token]
        output << operator_stack.pop
      end
      operator_stack.push(token)
    end
  end

  while !operator_stack.empty?
    output << operator_stack.pop
  end

  output
end

def evaluate_postfix(postfix, methods_instance)
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
    elsif token == '√'
      a = stack.pop
      stack.push(methods_instance.sqrt(a))
    end
  end

  stack.pop
end

def evaluate_expression(display, methods_instance)
  begin
    postfix = to_postfix($current_input)
    result = evaluate_postfix(postfix, methods_instance)

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

def handle_odd_to_file(methods_instance, range_start, range_end, display)
  start_val = range_start.value.to_i
  end_val = range_end.value.to_i

  if start_val >= end_val
    display.text = "Invalid Range"
  else
    methods_instance.generateOddToFile([start_val, end_val], "odd_numbers.txt")
    display.text = "Odd numbers saved to file."
  end
end

def odd_popup(methods_instance, display)
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
    command { handle_odd_to_file(methods_instance, range_start, range_end, display) }
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
button_frame = TkFrame.new(root).pack
buttons = [
  ['(', ')', 'sqrt', '/'],
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

buttons.each_with_index do |row, row_index|
  row.each_with_index do |button_text, col_index|
    button = TkButton.new(button_frame) do
      text button_text
      width 5
      height 2
      font TkFont.new('times 15 bold')
      grid('row' => row_index, 'column' => col_index, 'padx' => 5, 'pady' => 5)

      command do
        case button_text
        when 'C'
          clear_display(display)
        when '='
          evaluate_expression(display, methods_instance)
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
          odd_popup(methods_instance, display)
        when 'sin'
          result = methods_instance.sin($current_input.to_f)
          display.text = result.to_s
          $current_input = result.to_s
        when 'cos'
          result = methods_instance.cos($current_input.to_f)
          display.text = result.to_s
          $current_input = result.to_s
        when 'tan'
          result = methods_instance.tan($current_input.to_f)
          display.text = result.to_s
          $current_input = result.to_s
        when 'abs'
          #TODO
        when 'cbrt'
          #TODO
        when 'genEven'
          #TODO
        when 'genSqrd'
          #TODO
        when 'log'
          #TODO
        when '!'
          #TODO
        when '%'
          #TODO
        when 'median'
          #TODO
        when 'genPrime'
          #TODO
        when 'min'
          #TODO
        when 'isPrime'
          #TODO
        when 'mode'
          #TODO
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