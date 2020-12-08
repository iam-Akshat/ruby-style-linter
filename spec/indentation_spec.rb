require_relative '../lib/linter_modules/indentation.rb'

describe 'linter_indentaion_module' do
  describe '.lint_indentation' do
    include Indentation
    it 'prints indentation errors given a file_path and file_name' do
      err = "[Style/Indentation] ./spec/dir_test_folder/test.rb:5 needs 2 extra spaces of indentation\n"\
            "[Style/Indentation] ./spec/dir_test_folder/test.rb:7 needs 4 extra spaces of indentation\n"
      file_path = Dir.getwd + '/spec/dir_test_folder/test.rb'
      expect { Indentation.lint_indentation(file_path, './spec/dir_test_folder/test.rb') }.to output(err).to_stdout
    end
  end
end
