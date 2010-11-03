class Assignment
	attr_accessor :from, :to
	def initialize(from)
		@from = from
		@to = nil
	end
	
	def has_to?
		@to != nil
	end
	
	def assign(p)
		@to = p
	end
end