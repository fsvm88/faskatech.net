module GenericFunctions
	def convAllToTime(time)
		time = Time.local(time.year, time.month, time.day) if time.is_a?(Date)
		time = Time.parse(time) if time.is_a?(String)
		time
	end

	def selectItemsOfKind(kind)
		@items.select { |item| item[:kind] == kind }
	end

	def sortKindByField(kind, sort_field)
		sorted_items = selectItemsOfKind(kind).sort_by do |a|
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

   def selectItemsOfExt(extension)
       @items.select { |item| item if item.raw_filename.end_with?(extension) }
   end
end
