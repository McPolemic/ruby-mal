#!/usr/bin/env ruby
require_relative "reader"
require_relative "printer"

# Don't buffer output so we can print our REPL
$stdout.sync = true

module Mal
  class << self
    def read(a)
      read_str(a)
    end

    def eval(a)
      a
    end

    def output(a)
      puts pr_str(a)
    end

    def rep(a)
      output(
        eval(
          read(a)
        )
      )
    end

    def main_loop
      loop do
        print('user> ')
        input = gets
        exit if input.nil?
        rep(input)
      end
    end
  end
end

Mal.main_loop
