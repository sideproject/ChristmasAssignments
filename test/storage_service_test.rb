require "test/unit"
require 'test/mock_file'
require 'storage_service'
require 'assignment'
require 'assignment_list'

class StorageServiceTest < Test::Unit::TestCase

	def test_load
		
		#file = File.open(filename, "r") {
		#}
		
		f = MockFile.new 'blah', 'r'
		family_members = StorageService.load_family_members f
		
		assert_equal 4, family_members.count
		assert_equal 'margaret', family_members.people[0].name
		assert_equal 'carla', family_members.people[1].name
		assert_equal 'james', family_members.people[2].name
		assert_equal 'emily', family_members.people[3].name
		
	end
	
	def test_save 
		#~ File.open(filename, 'w') {|f| 
			#~ FamilyMembers.save 
		#~ }
		
		f = MockFile.new 'blah', 'w'
		assignment_list = AssignmentList.new
		
		eliz = Person.new 'eliz', 1, :child, ['x','y']
		mom = Person.new 'margaret', 1, :parent, ['mary','anne']
		
		assignment_list.add_assignment(eliz)
		assignment_list.assignments[0].assign(mom)
				
		elise = Person.new 'elise',  1, :parent, ['james','hollie']
		christopher = Person.new 'christopher', 1, :child, ['shawn','daniel']		
		assignment_list.add_assignment(elise)
		assignment_list.assignments[1].assign(christopher)
		
		assignment_list.accept_list!
		
		StorageService.save_assignment_list(f, assignment_list)
		assert_equal 3, f.get_input.count #+1 for file header
		
		assert_equal 'Eliz:1:child:X,Y,Margaret', f.get_input[1]
		assert_equal 'Elise:1:parent:James,Hollie,Christopher', f.get_input[2]

	end
	
end