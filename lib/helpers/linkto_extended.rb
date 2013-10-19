module LinkToExtended

	def link_to_unless_current_withid(text, target, extra_attrs={})
		path = target.is_a?(String) ? target : target.path

		if @item_rep && @item_rep.path == path
			return "<span class=\"active\" id=\"currently_active_item\" title=\"You're here!\">#{text}</span>"
		end

		link_to_unless_current(text, target, extra_attrs)
	end

end
