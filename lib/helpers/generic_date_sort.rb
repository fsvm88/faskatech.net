module GenericDatesort
	def generic_attribute_to_time(time)
		time = Time.local(time.year, time.month, time.day) if time.is_a?(Date)
		time = Time.parse(time) if time.is_a?(String)
		time
	end

	def my_items(kind)
		@items.select { |item| item[:kind] == kind }
	end

	def generic_sorted(kind, sort_field)
		sorted_items = my_items(kind).sort_by do |a|
				if ( sort_field == 'time' )
					attribute_to_time(a[:date])
				else
					a[:sort_field]
				end
			end
		if (sort_field == 'time' )
			sorted_items.reverse
		else
			sorted_items
		end
	end
end
