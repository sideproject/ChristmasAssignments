class PersonList
	
	def initialize
		@person_list = []
	end
	
	def add_person(p)
		@person_list.push p
	end
	
	def count
		@person_list.count
	end
	
	def reorder!
		@person_list.each {|person| 
			person.random_id = rand(500)
		}
	end
	
	def people
		@person_list
	end
	
end