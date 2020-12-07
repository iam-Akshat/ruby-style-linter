module Indentation
  class Indenter
    def check_indentation(file_path, file_name)
      line_number = 0
      nesting_level = 0
      IO.foreach(file_path) do |line|
        line_number += 1

        line_without_strings = sanitize_line(line)
        # puts line
        puts "#{file_name}:#{line_number}" unless proper_indentation?(line_without_strings, nesting_level)
        next if comment?(line)

        nesting_level += 1 if indentation_increase?(line_without_strings)

        nesting_level -= 1 if indent_decrease?(line_without_strings)
      end
    end

    private

    def indentation_increase?(line)
      indent_increasing_tokens = %w[do class def module else elsif if]
      indent_increasing_tokens.each do |breaker|
        reg = Regexp.new(/\b#{breaker}\b/)
        next unless line.match?(reg)

        if breaker == 'if'
          guard_like_statement?(line) and return false
          return true
        end
        return true
      end
      false
    end

    def proper_indentation?(line, level = 0)
      # puts line.lstrip
      level -= 1 if (indent_decrease?(line) && !comment?(line)) || local_indent_decrease?(line)
      return true if new_line?(line)

      striped_line_length = line.lstrip.length
      line.length - striped_line_length == level * 2 and return true
      false
    end
    # Removes strings from line
    # Example: "puts "as" and puts "sa"" => "puts and puts"

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
      decrease_symbols = %w[end else elsif]
      decrease_symbols.each do |symbol|
        reg = Regexp.new(/\b#{symbol}\b/)
        line.match?(reg) and return true
      end

      false
    end

    def local_indent_decrease?(line)
      local_decrease_symbols = %w[else elsif]
      local_decrease_symbols.each do |symbol|
        reg = Regexp.new(/\b#{symbol}\b/)
        line.match?(reg) and return true
      end
      false
    end

    def guard_like_statement?(line)
      part = line.strip.partition(/\bif\b/)
      part[0] == '' and return false
      true
    end
  end

  def self.lint_indentation(file_path, file_name)
    ind = Indenter.new
    ind.check_indentation(file_path, file_name)
  end
end
