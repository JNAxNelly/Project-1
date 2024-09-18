require 'tk'
require_relative 'Methods1'
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
  ['hexa']
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
          result = methods_instance1.exponent($current_input.to_f)
          display.text = result.to_s
          $current_input = result.to_s
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
          minimum_popup(methods_instance3, display)
        when 'isPrime'
          prime_popup(methods_instance3, display)
        when 'mode'
          mode_popup(methods_instance3, display)
        when 'binary'
          #TODO
        when 'octal'
          #TODO
        when 'hexa'
          #TODO
        when 'mean'
          #TODO
        when 'max'
          #TODO
        when 'genFib'
          #TODO
        else
          update_display(button_text, display)
        end
      end
    end
  end
end

Tk.mainloop