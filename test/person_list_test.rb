#require File.expand_path(File.dirname(__FILE__) + "../FamilyMemberList")
require 'person_list'
require 'test/mock_file'

class PersonListTest < Test::Unit::TestCase
	def test_reorder
		f = MockFile.new 'blah', 'r'
		family_members = StorageService.load_family_members f
		
		old_id = family_members.people[0].random_id
		family_members.reorder!
		assert_not_equal old_id, family_members.people[0].random_id
		
	end
end