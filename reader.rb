require_relative "types"

class Reader
  def initialize(tokens = [])
    @tokens = tokens
    @position = 0
  end

  # Return the current token and increment the position
  def next
    peek.tap { @position += 1 }
  end

  # Return the current token
  def peek
    @tokens[@position]
  end
end

def read_str(input)
  tokens = tokenize(input)
  return nil if tokens.size == 0
  read_form(Reader.new(tokens))
end

def tokenize(input)
  re = /[\s,]*(~@|[\[\]{}()'`~^@]|"(?:\\.|[^\\"])*"?|;.*|[^\s\[\]{}('"`,;)]*)/
  input
    .scan(re)
    .map(&:first)
    .reject{ |t| t.empty? || t.start_with?(";")  }
end

def read_form(reader)
  first_char = reader.peek

  case first_char
  when '('
    read_list(reader, List, open: '(', close: ')')
  when '['
    read_list(reader, Vector, open: '[', close: ']')
  when '{'
    HashMap[read_list(reader, List, open: '{', close: '}').each_slice(2).to_a]
  else
    read_atom(reader)
  end
end

def read_list(reader, klass, open:, close:)
  ast = klass.new
  token = reader.next # Clear the leading '('
  if token != open
    raise "expected '#{open}'"
  end

  until (token = reader.peek) == close
    if not token
      raise "expected '#{close}', got EOF"
    end
    token = read_form(reader)

    ast << token
  end

  token = reader.next # Clear the trailing ')'

  ast
end

def read_atom(reader)
  token = reader.next

  case token
  when /^-?\d+$/ then     token.to_i
  when /^-?\d+.\d+$/ then token.to_f
  when /^"/ then          parse_string(token)
  when /^:/ then          parse_keyword(token)
  when "true" then        true
  when "false" then       false
  when "nil" then         nil
  else                    token.to_sym
  end
end

def parse_keyword(token)
  Keyword.new(token[1..-1])
end

def parse_string(token)
  token[1...-1]
    .gsub('\"', '"')
    .gsub("\\n", "\n")
    .gsub("\\\\", "\\") # Has to be last or it will mess with escaped
                        # characters
end
