# file for testing linter
# rubocop:disable all
a = 1
if a < 3
puts "True"
  if a+1 <4
puts a
    next if a==2
    unless 2>1
      puts a
    end
  end
end
# rubocop:enable all