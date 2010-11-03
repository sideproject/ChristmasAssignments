class MockFile
	def initialize(file_name, access_type)
		@in_lines = ['FirstName:FamilyId:Type:PreviousAssignments',
				'margaret:1:parent:mary,anne',
				'carla:4:parent:anne,mary',
				'james:5:child:mallory,christopher',
				'emily:2:child:sam,julia']
		@iterator = 0
		@out_lines = []
	end
	
	def gets
		if @iterator < 5
			s = @in_lines[@iterator]
			@iterator += 1
			return s
		end
		
		return nil
	end
	
	def puts(line)
		@out_lines.push line
	end
	
	def open(file_name, access_type)
	end
	
	def get_input
		@out_lines
	end
end