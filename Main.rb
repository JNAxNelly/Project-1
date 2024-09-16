require 'tk'

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
  tokens = expression.scan(/\d+\.?\d*|\+|\-|\*|\/|\^|\(|\)|√/) # Scan for numbers and operators

  tokens.each do |token|
    if token =~ /\d/
      output << token # If it's a number, add to the output
    elsif token == '('
      operator_stack.push(token) # Push '(' to the stack
    elsif token == ')'
      # Pop from the stack to the output until '(' is found
      while operator_stack.last != '('
        output << operator_stack.pop
      end
      operator_stack.pop # Remove '('
    elsif OPERATORS[token]
      while !operator_stack.empty? && OPERATORS[operator_stack.last] && OPERATORS[operator_stack.last] >= OPERATORS[token]
        output << operator_stack.pop
      end
      operator_stack.push(token) # Push the operator to the stack
    end
  end

  # Pop any remaining operators in the stack
  while !operator_stack.empty?
    output << operator_stack.pop
  end

  output
end

# Evaluate the postfix expression
def evaluate_postfix(postfix)
  stack = []

  postfix.each do |token|
    if token =~ /\d/
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
      stack.push(Math.sqrt(a))
    end
  end

  stack.pop
end

# Method to evaluate expressions without eval
def evaluate_expression(display)
  begin
    # Convert the current input to postfix notation
    postfix = to_postfix($current_input)

    # Evaluate the postfix expression
    result = evaluate_postfix(postfix)

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

# Create the buttons for the calculator
button_frame = TkFrame.new(root).pack
buttons = [
  ['(', ')', '√', '/'],
  ['7', '8', '9', '*'],
  ['4', '5', '6', '-'],
  ['1', '2', '3', '+'],
  ['C', '0', '=', '^']
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
          evaluate_expression(display)
        else
          update_display(button_text, display)
        end
      end
    end
  end
end

# Start the Tk main loop
Tk.mainloop