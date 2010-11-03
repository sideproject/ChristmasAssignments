class AssignmentRules

	def initialize(person_from, person_to)
		@person_from = person_from
		@person_to = person_to
	end
	
	def is_not_self? 
		@person_from.name != @person_to.name
	end
	
	def is_unassigned? (assignment_index)
		assignment_index[@person_to.name].nil?
	end
	
	def is_different_family? 
		@person_from.family_id != @person_to.family_id
	end
		
	def not_previously_assigned?
		#not someone you've had previously
		!@person_from.previous_assignments.include?(@person_to.name)
	end
	
	def is_correct_parent_child_ratio? (family_assignments)
		
		parent_counter = 0
		child_counter = 0			
			
		#keep track of how many children and parents have been assigned for the current family
		
		if !family_assignments.nil?
			family_assignments.each { |x| 
				parent_counter += 1 if x.type == :parent
				child_counter += 1 if x.type == :child
			}
		end
		
		#max 2 parents and max 3 children
		ok = false
		ok |= @person_to.type == :parent && parent_counter < 2
		ok |= @person_to.type == :child && child_counter < 3
		ok
	end
	
	def uncombinable_people_ok?(family_has_uncombinable_person, uncombinable_people)
		#don't asssign more than one problem person per family		
		return true if !family_has_uncombinable_person
		return !uncombinable_people.include?(@person_to.name)
	end
	
	
	def has_good_family_mix?(family_assignments)
		#make sure that we don't assign one family all of another family (max 50% same family)
		
		if !family_assignments.nil?
			families = Array.new
			family_assignments.each { |f| 
				families.push(f.family_id) if !families.include?(f.family_id)
			}
						
			total_members = family_assignments.count * 1.0
			total_members += 1 #plus the one we're adding
			
			return true if total_members <= 2
			
			distinct_families = families.count * 1.0
			distinct_families += 1 if !families.include?(@person_to.family_id)
			
			#puts distinct_families.to_s + '/' + total_members.to_s + '=' +  (distinct_families / total_members).to_s
			return (distinct_families / total_members) > 0.5
			
		end		
		return true
		
	end
	
	def no_previous_family_assignments?(last_year_family_assignment_names)
		#don't allow a family to get the same person twice in a row
		if !last_year_family_assignment_names.nil?
			last_year_family_assignment_names.each {|prev_name|
				return false if @person_to.name == prev_name
			}
		end
		
		return true
		
	end
	

end