require_relative 'linter_helper.rb'
require_relative './linter_modules/indentation.rb'
class Linter
  include LinterHelpers
  include Indentation
  def initialize(start_directory)
    @file_store = {}
    LinterHelpers.traverse_dir(start_directory, @file_store)
  end

  def lint
    starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    @file_store.each do |file_path, _file_name|
      Indentation.lint_indentation(file_path, file_path.gsub(Dir.getwd, ''))
    end
    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    puts "Processed #{@file_store.length} files in #{ending-starting} seconds"
  end
end
