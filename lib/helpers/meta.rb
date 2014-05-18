module Meta

	def get_metas_for_head(item)
		metas = Hash.new
		metas["author"] = 'Fabio Scaccabarozzi'
		metas["generator"] = 'nanoc'
		if item[:title]
			metas["title"] = item[:title]
		else
			metas["title"] = 'Faskatech | Linux projects for power users'
		end
		
		if item[:desc]
			metas["desc"] = item[:desc]
		else
			metas["desc"] = 'Linux projects for power users: reiser4+truecrypt enabled liveCDs, custom Gentoo overlays, linux guides and scripts.'
		end

		if item[:keywords]
			metas["keywords"] = item[:keywords]
		else
			metas["keywords"] = 'reiser4, livecd, live-cd, live, cd, linux, truecrypt'
		end

		headAppend = Array.new
		headAppend << "<title>#metas[\"title\"]</title>"
		metas.each do | key, value |
			headAppend << "<meta name=\"#key\" content=\"#value\">"
		end
	end

end
