require_relative 'linter_helper'
require_relative './linter_modules/indentation'
class Linter
  include LinterHelpers
  include Indentation
  def initialize(start_directory)
    @file_store = {}
    if Dir.exist?(start_directory)
      LinterHelpers.traverse_dir(start_directory, @file_store)
    elsif start_directory.split('.')[-1] == 'rb'
      @file_store[start_directory] = start_directory.split('/')[-1]
    end
  end

  def lint
    starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    @file_store.each do |file_path, _file_name|
      Indentation.lint_indentation(file_path, file_path.gsub(Dir.getwd, ''))
    end
    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    puts "Processed #{@file_store.length} files in #{ending - starting} seconds"
  end
end
