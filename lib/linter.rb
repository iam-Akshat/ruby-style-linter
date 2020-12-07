require_relative 'linter_helper.rb'
class Linter
  include LinterHelpers
  

  def initialize(start_directory)
    @file_store = {}
    traverse_dir(start_directory, @file_store)
  end

  def lint
    @file_store.each do |file_path,file_name|
      read_file_by_line(file_path,file_name)
    end
  end

  def read_file_by_line(file_path,file_name)
    line_number = 0
    nesting_level = 0
    IO.foreach(file_path) do |line|
      line_number += 1
      
      line_without_strings = sanitize_line(line)
      # puts line
      puts "#{file_name}:#{line_number}:bad indentation #{nesting_level}" unless check_proper_indentation(line_without_strings, nesting_level)
      next if comment?(line)
      nesting_level += 1 if code_indentation_increaser(line_without_strings)

      nesting_level -= 1 if indent_decrease?(line_without_strings)
    end
  end

  def code_indentation_increaser(line)
    #return true if line.lstrip[0,2] == 'if'

    arr = %w[do class def module else elsif]
    arr.each do |breaker|
      reg = Regexp.new(/\b#{breaker}\b/)
      line.match?(reg) and return true
    end
    false
  end
  def check_proper_indentation(line, level = 0)
    # puts line.lstrip
    level -= 1 if indent_decrease?(line) && !comment?(line)
    return true if new_line?(line)
  
    striped_line_length = line.lstrip.length
    line.length - striped_line_length == level * 2 and return true
    false
  end
  # Removes strings from line ||
  # puts "as" and puts "sa" => puts and puts 

  def sanitize_line(line)
    strip_strings = Regexp.new(/['"\[](.*?)['"\]]/)
    line.gsub(strip_strings, '')
  end

  def comment?(line)
    line.strip[0] == '#'
  end

  def new_line?(line)
    line.strip.length.zero?
  end

  def tab?(line)
    line.include?("\t")
  end

  def indent_decrease?(line)
    line.match?(/\bend\b/)
  end
end

linter = Linter.new(ARGV[0] ||Dir.getwd)

linter.lint
