require "rb-readline"

# https://stackoverflow.com/questions/2108727/which-in-ruby-checking-if-program-exists-in-path-from-ruby
def which(cmd)
  exts = ENV["PATHEXT"] ? ENV["PATHEXT"].split(";") : [""]
  ENV["PATH"].split(File::PATH_SEPARATOR).each do |path|
    exts.each { |ext|
      exe = File.join(path, "#{cmd}#{ext}")
      return exe if File.executable?(exe) && !File.directory?(exe)
    }
  end
  return nil
end

if which("fzf") != nil
  # https://stackoverflow.com/questions/46167332/how-to-i-make-reverse-i-search-history-use-fzf-in-irb-or-pry-console
  def RbReadline.rl_reverse_search_history(sign, key)
    rl_insert_text `cat #{Pry.config.history.file} | fzf --tac |  tr '\n' ' '`
  end
end
