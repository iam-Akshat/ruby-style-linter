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
    @file_store.each do |file_path, file_name|
      check_indentation(file_path, file_name)
      indentation_increase?('dsdsds')
    end
  end
end
