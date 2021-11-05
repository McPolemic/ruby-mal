require 'stringio'

def run(input_program)
  output = StringIO.new
  old_stdout = $stdout
  $stdout = output

  rep(input_program)

  $stdout = old_stdout
  output.string.chomp
end
