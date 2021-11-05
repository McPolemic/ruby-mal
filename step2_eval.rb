#!/usr/bin/env ruby
require_relative "reader"
require_relative "printer"
require_relative "types"
require_relative "mal_readline"

# Don't buffer output so we can print our REPL
$stdout.sync = true

REPL_ENV = {
  :+ => ->(a, b) { a + b },
  :- => ->(a, b) { a - b },
  :* => ->(a, b) { a * b },
  :/ => ->(a, b) { a / b },
}

def READ(input)
  read_str(input)
end

def EVAL(ast, env)
  case ast
  when List
    return ast if ast.empty?
    ast = eval_ast(ast, env)
    func = ast.first
    func.(ast[1], ast[2])
  else
    eval_ast(ast, env)
  end
end

def eval_ast(ast, env)
  case ast
  when Symbol
    raise "'" + ast.to_s + "' not found" unless env.include? ast
    env[ast]
  when List
    List.new(ast.map { |token| EVAL(token, env) })
  when Vector
    Vector.new(ast.map { |token| EVAL(token, env) })
  when HashMap
    HashMap[ast.map { |key, value| [EVAL(key, env), EVAL(value, env)] }.to_h]
  else
    ast
  end
end

def PRINT(ast)
  puts pr_str(ast)
end

def rep(input)
  PRINT(
    EVAL(READ(input), REPL_ENV)
  )
end

def main_loop
  while input = readline_get_input
    begin
      rep(input)
    rescue Exception => e
      puts "Error: #{e}"
      puts "\t#{e.backtrace.join("\n\t")}"
    end
  end
end

main_loop if $0 == __FILE__
