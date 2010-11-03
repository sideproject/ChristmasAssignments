require 'person'
require 'person_list'

class StorageService
	:public
	def self.load_family_members(f)
		family_members = PersonList.new
		
		f.gets #skip header row
		while (line = f.gets)
			name = ''
			family = ''
			previous = Array.new
			line.chomp!
			line.downcase!

			next if !line.include?(':') or line.include?('#')
			person = line.split(':')
			name = person[0]
			family_id = person[1]
			type = person[2].intern #get :child or :parent symbol

			previous_array = person[3].split(',')  if person.length >= 4
			
			p = Person.new name, family_id, type, previous_array
			family_members.add_person p
		end
		return family_members
	end
	
	def self.save_assignment_list(f, assignment_list)
		assignment_list = assignment_list.sort_asc
		
		f.puts 'FirstName:FamilyId:Type:PreviousAssignments'
		assignment_list.each{|assignment|

			out = ''
			out << assignment.from.name.capitalize
			out << ':' << assignment.from.family_id.to_s
			out << ':' << assignment.from.type.to_s
			
			out << ':'
			if assignment.from.previous_assignments.length > 0
				assignment.from.previous_assignments.each{ |a| 
					out << a.capitalize << ','
				}
			end
			
			f.puts out.chomp(',')
		}
	end
	
end
