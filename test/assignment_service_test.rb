require "test/unit"
require 'person'
require 'assignment_service'


class MockFamilyMemberList
	def self.make
		list = Array.new		
		list.push Person.new 'eliz',  1, :child, ['x','y'], 321
		list.push Person.new 'margaret', 1, :parent, ['mary','anne'], 110
		list.push Person.new 'elise', 1, :parent, ['james','hollie'], 463
		list.push Person.new 'christopher', 1, :child, ['shawn','daniel'], 143 
		list.push Person.new 'julia', 1, :child, ['carla','mallory'], 371
		list.push Person.new 'charlie', 2, :parent, ['jim','dean'], 21
		list.push Person.new 'anne', 2, :parent, ['arah','carla'], 404
		list.push Person.new 'emily', 2, :child, ['sam','james'], 269
		list.push Person.new 'laura', 2, :child,['martha','andrew'], 480
		list.push Person.new 'jim', 3, :parent, ['daniel','charlie'], 90
		list.push Person.new 'hollie', 3, :parent, ['elise','sarah'], 213
		list.push Person.new 'andrew', 3, :child,[' joeseph','sam'], 347
		list.push Person.new 'amie', 3, :child, ['emily','martha'], 481
		list.push Person.new 'frank', 4, :parent, ['margaret','shawn'], 17
		list.push Person.new 'carla', 4, :parent, ['anne','mary'], 486
		list.push Person.new 'mallory', 4, :child, ['christopher','joseph'], 10
		list.push Person.new 'martha', 4, :child, ['amie','julia'], 397
		list.push Person.new 'mary', 5, :parent, ['hollie','elise'], 448
		list.push Person.new 'dean', 5, :parent, ['frank','jim'], 440
		list.push Person.new 'james',  5, :child, ['mallory','christopher'], 358
		list.push Person.new 'joeseph', 5, :child, ['andrew','laura'], 69
		list.push Person.new 'sarah', 6, :parent, ['charlie','margaret'], 307
		list.push Person.new 'shawn', 6, :parent, ['dean','frank'], 47
		list.push Person.new 'sam', 6, :child, ['laura','amie'], 298
		list.push Person.new 'daniel', 6, :child, ['julia','emily'], 271

	end
end

class AssignmentServiceTest < Test::Unit::TestCase

	def test_get_new_assignments
		new_assignments = AssignmentService.get_new_assignments(MockFamilyMemberList.make)
		
		assert_equal 25, new_assignments.assignments.count
		assert_equal true, new_assignments.everyone_assigned?
			
		new_assignments.assignments.each {|a|
			assert_equal true, a.from.previous_assignments.include?(a.to.name) 
			assert_not_equal a.from.family_id, a.to.family_id
			assert_not_equal a.from.person_id, a.to.person_id
			assert_equal 3, a.from.previous_assignments.count
		}		
	end
	
end


