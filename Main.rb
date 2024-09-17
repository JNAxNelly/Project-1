require 'tk'
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

# Define operator precedence
OPERATORS = {
  '+' => 1,
  '-' => 1,
  '*' => 2,
  '/' => 2,
  '^' => 3,
  '√' => 4
}

# Create an instance of the Methods3 class
methods_instance = Methods3.new

# Update display method
def update_display(new_value, display)
  $current_input += new_value
  display.text = $current_input
end

# Clear display method
def clear_display(display)
  $current_input = ''
  display.text = '0'
end

# Convert the infix expression (as entered by the user) into postfix notation
def to_postfix(expression)
  output = []
  operator_stack = []
  tokens = expression.scan(/-?\d+\.?\d*|\+|\-|\*|\/|\^|\(|\)|√/) # Scan for numbers and operators

  tokens.each_with_index do |token, index|
    if token =~ /-?\d/ # Numbers (including negative numbers)
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

# Evaluate the postfix expression
def evaluate_postfix(postfix, methods_instance)
  stack = []

  postfix.each do |token|
    if token =~ /-?\d/
      stack.push(token.to_f) # Push numbers to the stack
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
        return Float::INFINITY # Handle divide by zero
      else
        stack.push(a / b)
      end
    elsif token == '^'
      b = stack.pop
      a = stack.pop
      stack.push(a**b)
    elsif token == '√'
      a = stack.pop
      stack.push(methods_instance.sqrt(a)) # Use Methods3's sqrt method
    end
  end

  stack.pop
end

# Method to evaluate expressions without eval
def evaluate_expression(display, methods_instance)
  begin
    # Convert the current input to postfix notation
    postfix = to_postfix($current_input)

    # Evaluate the postfix expression
    result = evaluate_postfix(postfix, methods_instance)

    # Handle division by zero and invalid results
    if result == Float::INFINITY || result.nan?
      display.text = 'Error: Division by Zero'
      $current_input = ''
    else
      # Update the display with the result
      display.text = result.to_s
      $current_input = result.to_s
    end
  rescue
    display.text = 'Error'
    $current_input = ''
  end
end

# Method for handling odd number generation and saving to file
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

# Popup for odd number range input
def odd_popup(methods_instance, display)
  popup = TkToplevel.new { title "Odd Number Generator" }

  range_label = TkLabel.new(popup) do
    text 'Enter range for odd numbers:'
    font TkFont.new('times 15 bold')
    pack { padx 10; pady 5 }
  end

  # Input fields for start and end range
  range_start = TkEntry.new(popup) do
    width 10
    pack { padx 10; pady 5 }
  end

  range_end = TkEntry.new(popup) do
    width 10
    pack { padx 10; pady 5 }
  end

  # Button to trigger the generation of odd numbers
  TkButton.new(popup) do
    text 'Generate Odd Numbers'
    command { handle_odd_to_file(methods_instance, range_start, range_end, display) }
    pack { padx 10; pady 10 }
  end
end

# Create the buttons for the calculator
button_frame = TkFrame.new(root).pack
buttons = [
  ['(', ')', '√', '/'],
  ['7', '8', '9', '*'],
  ['4', '5', '6', '-'],
  ['1', '2', '3', '+'],
  ['C', '0', '=', '^'],
  ['Neg', 'sin', 'cos', 'tan', 'Odd'] 
  
  
  # Changed 'OddToFile' to 'Odd'
]

# Create number buttons 0-9 and operator buttons
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
            # If the last character is an operator, append negative sign
            if $current_input[-1] =~ /[\+\-\*\/]/
              update_display('-', display)
            elsif $current_input[-1] != '('
              $current_input = "-#{$current_input}" unless $current_input.start_with?('-')
              display.text = $current_input
            end
          else
            update_display('-', display)
          end
        when 'Odd'
          odd_popup(methods_instance, display) # Call odd_popup when "Odd" button is clicked
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
        else
          update_display(button_text, display)
        end
      end
    end
  end
end

# Start the Tk main loop
Tk.mainloop