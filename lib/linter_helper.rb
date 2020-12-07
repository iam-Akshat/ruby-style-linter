module LinterHelpers
  def traverse_dir(root, store, filter = 'rb')
    Dir.foreach(root) do |x|
      path = File.join(root, x)
      next if (x == '.') || (x == '..')

      if Dir.exist?(path)
        traverse_dir(path, store)
      else
        x.split('.')[-1] == filter and store[path] = x
      end
    end
  end
end
