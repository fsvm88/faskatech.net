module Tags

	def tags(item)
		if item[:tags].nil?
			'(none)'
		else
			item[:tags].join(', ')
		end
	end

end
