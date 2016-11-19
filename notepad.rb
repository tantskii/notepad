if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'post.rb'
require_relative 'task.rb'
require_relative 'memo.rb'
require_relative 'link.rb'

choices = Post.post_types

choice = -1

while ((choice < 0) or (choice >= choices.size))

  for i in 0...choices.size
    puts "#{i+1}. " + choices[i].to_s
  end

  choice = STDIN.gets.chomp.to_i - 1
end

entry = Post.create(choice)

entry.read_from_console
entry.save

puts "Запись сохранена."