require "rb-readline"

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
  def RbReadline.rl_reverse_search_history(sign, key)
    rl_insert_text `cat #{Pry.config.history.file} | fzf --tac |  tr '\n' ' '`
  end
end
