require 'assignment'
require 'person'

class AssignmentList
	
	def initialize
		@assignments = Array.new
	end
	
	def add_assignment(p)
		@assignments.push(Assignment.new p)
	end
	
	def assignments
		@assignments
	end
	
	def randomize!
		@assignments.sort!{|x,y| x.from.random_id<=>y.from.random_id }
	end
	
	def everyone_assigned?
		@assignments.each {|a|
			return false if !a.has_to? 
		}
		return true
	end
	
	#add the receiver to the giver's previous_asssignment list
	def accept_list!
		@assignments.each {|a|
			a.from.previous_assignments.push(a.to.name)
		}
	end
	
	def sort_asc
		@assignments.sort{|x,y| x.from.person_id<=>y.from.person_id }
	end
	
	def print
		out = ''
		sort_asc.each{|a|
			to = a.has_to? ? a.to.name : '?'
			out << a.from.name + ":" + to
			#out << a.from.random_id.to_s
			out << "\n"
		}
		out
    end

end