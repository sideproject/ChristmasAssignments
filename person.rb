class Person 
	:private
	@@count=0

	def initialize(name, family_id = 0, type= :child, previous_assignments = Array.new, random_id = rand(500))
		@name = name
		@family_id = family_id
		@type = type
		@random_id = random_id
		@person_id = @@count += 1
		@previous_assignments = previous_assignments
	end

	:public
	attr_accessor :family_id, :name, :random_id, :person_id, :previous_assignments, :type

	def to_s
		out = ''
		out << 'name=' + @name 
		out << ':family_id=' + @family_id.to_s
		out << ':random_id=' + @random_id.to_s
		out << ':person_id=' + @person_id.to_s 
		out << ':type=' + @type.to_s
		out<< ':previous_assignments='
			@previous_assignments.each{ |p| 
				out << p.to_s + ','
			}
		out.chomp(',')
	end
end