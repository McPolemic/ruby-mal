#!/usr/bin/env ruby
require 'readline'

# Don't buffer output so we can print our REPL
$stdout.sync = true

codes = %w(this that the other).sort
comp = proc { |s| codes.grep( /^#{Regexp.escape(s)}/ ) }
Readline.completion_proc = comp

module Mal
  class << self
    def read(a)
      a
    end

    def eval(a)
      a
    end

    def output(a)
      puts a
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
        input = Readline.readline('user> ', true)
        exit if input.nil?
        rep(input)
      end
    end
  end
end

Mal.main_loop
