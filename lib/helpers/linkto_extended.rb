module LinkToExtended

	def linkto_unless_current_withid(text, item, extra_attrs)
		if extra_attrs.empty?
			params = { :id => 'currently_active_item' }
		else
			params = extra_attrs.merge({ :id => 'currently_active_item' })
		end
		linkto_unless_current(text, item, params)
	end

end
