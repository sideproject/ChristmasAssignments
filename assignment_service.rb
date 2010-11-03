require 'person'
require 'assignment'
require 'assignment_list'
require 'assignment_rules'

class AssignmentService
	
	def self.get_new_assignments(family_members)

		uncombinable_people = ['jim', 'andrew', 'frank']
		assignments = AssignmentList.new
		last_year_family_assignment_names = Hash.new
		reverse_assignment_index = Hash.new
		family_assignments = Hash.new
		family_has_uncombinable_person = Hash.new
		
		family_members.each {|fm|
			assignments.add_assignment fm
			
			last_year_family_assignment_names[fm.family_id] = Array.new if !last_year_family_assignment_names.has_key?(fm.family_id)
			last_year_family_assignment_names[fm.family_id] .push fm.previous_assignments[-1]
		}
		
		assignments.randomize!
		assignments.assignments.each {|a|
			
			buyer = a.from
			next if a.has_to?
							
			family_members.each{ |receiver|
			
				this_family_has_uncombinable_person = family_has_uncombinable_person[buyer.family_id]
				this_familys_assignments = family_assignments[buyer.family_id]
				this_familys_last_year_assignment_names = last_year_family_assignment_names[buyer.family_id]
			
				rules = AssignmentRules.new(buyer, receiver)
				ok = rules.is_not_self?
				ok &= rules.is_unassigned?(reverse_assignment_index) if ok
				ok &= rules.is_different_family? if ok
				ok &= rules.not_previously_assigned? if ok
				ok &= rules.is_correct_parent_child_ratio?(this_familys_assignments) if ok
				ok &= rules.uncombinable_people_ok?(this_family_has_uncombinable_person, uncombinable_people) if ok
				ok &= rules.has_good_family_mix?(this_familys_assignments) if ok
				ok &= rules.no_previous_family_assignments?(this_familys_last_year_assignment_names) if ok
				
				if (ok)
					a.assign(receiver)
					reverse_assignment_index[receiver.name] = buyer.name
					
					family_assignments[buyer.family_id] = Array.new if !family_assignments.has_key?(buyer.family_id)
					family_assignments[buyer.family_id].push(receiver)

					family_has_uncombinable_person[buyer.family_id] = false if !family_has_uncombinable_person.has_key?(buyer.family_id)
					family_has_uncombinable_person[buyer.family_id] |= uncombinable_people.include?(receiver.name)
					
					break
				end
			}
		}
		
		#add the receiver to the gift giver's previous_list since we have a complete list
		assignments.accept_list! if assignments.everyone_assigned?
		
		return assignments
		
	end
end