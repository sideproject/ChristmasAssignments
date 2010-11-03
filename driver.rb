require 'person_list'
require 'storage_service'
require 'assignment_service'

list_complete = false
tries = total_tries = solution_count = 0
family_members = nil

input_file_name = 'data/input'
output_file_name = 'data/output'

File.open(input_file_name, 'r') {|f| 
	family_members = StorageService.load_family_members f 
}

65.times {|x| 
	list_complete = false
	assignments = nil
	tries = 0
	
	200.times {|y|
		family_members.reorder!
		assignments = AssignmentService.get_new_assignments(family_members.people)
		tries += 1
		total_tries += 1
		
		if assignments.everyone_assigned? 
			solution_count += 1
			puts "SOLUTION ##{solution_count}"
			puts assignments.print
			puts "Tries: " + tries.to_s
			puts

			File.open(output_file_name, 'w') {|f| 
				StorageService.save_assignment_list(f, assignments) 
			}
			break
		end
	}
}

puts 'Total Runs: ' + total_tries.to_s
puts 'Solution Count: ' + solution_count.to_s