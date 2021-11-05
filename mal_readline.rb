require 'fileutils'
require 'pathname'
require 'readline'

HISTORY_FILE = Pathname.new("~/.cache/mal/mal-history").expand_path
$history_loaded = false

def readline_get_input(prompt: "user> ")
  # Create history file if it doesn't exist
  unless HISTORY_FILE.exist?
    FileUtils.mkpath(HISTORY_FILE.dirname)
    FileUtils.touch(HISTORY_FILE)
  end

  # Load history and throw it into Readline's HISTORY constant
  unless $history_loaded && HISTORY_FILE.readable?
    File.read(HISTORY_FILE)
      .split("\n")
      .each { |line| Readline::HISTORY.push(line) }
  end

  if line = Readline.readline(prompt, true)
    File.open(HISTORY_FILE, "a+") { |f| f.write(line + "\n") }

    line
  else
    nil
  end
end
