require "test/unit"
require 'person'
require 'assignment_rules'

class AssignmentRulesTest < Test::Unit::TestCase
	
	def test_is_not_self_false
		mom = Person.new 'margaret', 1, :parent, ['mary','anne']
		eliz = Person.new 'eliz', 1, :child, ['x','y']
		rules = AssignmentRules.new(mom, eliz)
		is_same = rules.is_not_self?
		assert_equal true, is_same
	end
	
	def test_is_not_self_false_true
		eliz1 = Person.new 'eliz', 1, :child, ['x','y']
		eliz2 = Person.new 'eliz', 1, :child, ['x','y']
		rules = AssignmentRules.new(eliz1, eliz2)
		is_same = rules.is_not_self?
		assert_equal false, is_same
	end
	
	def test_is_correct_parent_child_ratio_true
		andrew = Person.new 'andrew', 3, :child, []
		daniel = Person.new 'daniel', 4, :child, []
		carla = Person.new 'carla', 5, :parent, []
		
		family_assignments = [andrew, daniel, carla]
		
		mom = Person.new 'margaret', 1, :parent, []
		mary = Person.new 'mary', 2, :parent, []
		
		rules = AssignmentRules.new(mom, mary)
		assert_equal true, rules.is_correct_parent_child_ratio?(family_assignments) 			
	end
	
	def test_is_correct_parent_child_ratio_false
		andrew = Person.new 'andrew', 3, :child, []
		dean = Person.new 'dean', 4, :parent, []
		carla = Person.new 'carla', 5, :parent, []
		
		family_assignments = [andrew, dean, carla]
		
		mom = Person.new 'margaret', 1, :parent, []
		mary = Person.new 'mary', 2, :parent, []
		
		rules = AssignmentRules.new(mom, mary)
		assert_equal false, rules.is_correct_parent_child_ratio?(family_assignments) 			
	end
	
	
	
	def test_uncombinable_people_ok_true1
				
		has_uncombinable_person = true
		uncombinable_people = ['jim', 'andrew']
		
		andrew = Person.new 'andrew', 3, :child, []
		daniel = Person.new 'daniel', 4, :child, []
		
		family_assignments = [andrew, daniel]
		
		mom = Person.new 'margaret', 1, :parent, []
		mary = Person.new 'mary', 2, :parent, []
		
		rules = AssignmentRules.new(mom, mary)
		assert_equal true, rules.uncombinable_people_ok?(has_uncombinable_person, uncombinable_people) 		
		
	end
	
	
	def test_uncombinable_people_ok_true2
				
		has_uncombinable_person = false
		uncombinable_people = ['jim', 'andrew']
		
		daniel = Person.new 'daniel', 4, :child, []
		
		family_assignments = [daniel]
		
		mom = Person.new 'margaret', 1, :parent, []
		jim = Person.new 'jim', 3, :parent, []
		
		rules = AssignmentRules.new(mom, jim)
		assert_equal true, rules.uncombinable_people_ok?(has_uncombinable_person, uncombinable_people) 		
		
	end
	
	def test_uncombinable_people_ok_false
				
		has_uncombinable_person = true
		uncombinable_people = ['jim', 'andrew']
		
		andrew = Person.new 'andrew', 3, :child, []
		daniel = Person.new 'daniel', 4, :child, []
		
		family_assignments = [andrew, daniel]
		
		mom = Person.new 'margaret', 1, :parent, []
		jim = Person.new 'jim', 3, :parent, []
		
		rules = AssignmentRules.new(mom, jim)
		assert_equal false, rules.uncombinable_people_ok?(has_uncombinable_person, uncombinable_people) 		
		
	end
	
	def test_has_good_family_mix_true
				
		andrew = Person.new 'andrew', 3, :child, []
		dean = Person.new 'dean', 4, :parent, []
		carla = Person.new 'carla', 5, :parent, []
		
		family_assignments = [andrew, dean, carla]
		
		mom = Person.new 'margaret', 1, :parent, []
		mary = Person.new 'mary', 2, :parent, []
		
		rules = AssignmentRules.new(mom, mary)
		assert_equal true, rules.has_good_family_mix?(family_assignments)
		
	end

	def test_has_good_family_mix_false
				
		andrew = Person.new 'andrew', 3, :child, []
		jim = Person.new 'jim', 3, :parent, []
		hollie = Person.new 'hollie', 3, :parent, []
		
		family_assignments= [andrew, jim, hollie]
		
		mom = Person.new 'margaret', 1, :parent, []
		mary = Person.new 'mary', 7, :parent, []
		
		rules = AssignmentRules.new(mom, mary)
		assert_equal false, rules.has_good_family_mix?(family_assignments)
		
	end
	
	def test_no_previous_family_assignments_true
		
		previous_family_assignment_names = ['hollie', 'dean', 'carla']
		
		mom = Person.new 'margaret', 1, :parent, []
		andrew = Person.new 'andrew', 3, :child, []
		
		rules = AssignmentRules.new(mom, andrew)
		assert_equal true, rules.no_previous_family_assignments?(previous_family_assignment_names)
	end
	
	def test_no_previous_family_assignments_false
		
		previous_family_assignment_names = ['andrew', 'dean', 'carla']
		
		mom = Person.new 'margaret', 1, :parent, []
		andrew = Person.new 'andrew', 3, :child, []
		
		rules = AssignmentRules.new(mom, andrew)
		assert_equal false, rules.no_previous_family_assignments?(previous_family_assignment_names)
		
	end

end