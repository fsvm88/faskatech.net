module SidebarExtended

	def getSidebarCapture (title, text)
		return "
		<h4>#{title}</h4>
		<p class=\"sections-sidetext\">
			#{text}
		</p>
		"
	end

end
