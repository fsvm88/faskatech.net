module SidebarExtended

	def get_sidebar_capture (title, text)
		return "
		<h4>#{title}</h4>
		<p class=\"sections-sidetext\">
			#{text}
		</p>
		"
	end

end
