module OverlayGetter
	def overlay_items(ov_name)
		@items.select { |item| ((item[:kind] == 'overlay') and (item[:overlay] == ov_name)) }
	end
end
