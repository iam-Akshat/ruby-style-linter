module LinterHelpers
  def traverse_dir(root, store, filter = 'rb')
    Dir.foreach(root) do |x|
      path = File.join(root, x)
      if (x == '.') || (x == '..')
        next
      # puts x
      elsif Dir.exist?(path)
        # puts x
        # puts File.join(root,x)
        traverse_dir(path, store)
      else
        x.split('.')[-1] == filter and store[path] = x
      end
    end
  end
end
include LinterHelpers
# file_map = {}
# traverse_dir(Dir.getwd, file_map)
# file_map.each do |path, name|
#   puts "#{path}:#{name}"
# end
