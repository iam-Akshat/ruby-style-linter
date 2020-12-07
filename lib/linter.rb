require_relative 'linter_helper.rb'
require_relative './linter_modules/indentation.rb'
class Linter
  include LinterHelpers
  include Indentation
  def initialize(start_directory)
    @file_store = {}
    traverse_dir(start_directory, @file_store)
  end

  def lint
    @file_store.each do |file_path, _file_name|
      Indentation.lint_indentation(file_path, file_path.gsub(Dir.getwd, ''))
    end
  end
end
