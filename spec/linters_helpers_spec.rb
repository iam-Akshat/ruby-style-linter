require_relative '../lib/linter_helper.rb'

describe 'LinterHelpers' do
  describe '#traverse_dir' do
    it 'takes starting path,a hash to store files with path, passing the filter which is an extension' do
      include LinterHelpers
      test_dir = "#{Dir.getwd}/spec/dir_test_folder/"
      file_store = {}
      LinterHelpers.traverse_dir(test_dir, file_store)
      expect(file_store).to include(
        "#{test_dir}test.rb" => 'test.rb',
        "#{test_dir}test_folder/2.rb" => '2.rb'
      )
    end
  end
end
