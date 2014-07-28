module Meta

	def getMetasForHead()
		metas = Hash.new
		metas["author"] = 'Fabio Scaccabarozzi'
		metas["generator"] = 'nanoc'
		if @item[:title]
			metas["title"] = @item[:title]
		else
			metas["title"] = 'Faskatech | Linux projects for power users'
		end
		
		if @item[:desc]
			metas["description"] = @item[:desc]
		else
			metas["description"] = 'Linux projects for power users: reiser4+truecrypt enabled liveCDs, custom Gentoo overlays, linux guides and scripts.'
		end

		if @item[:keywords]
			metas["keywords"] = @item[:keywords].gsub(/\s+/, "")
		else
			metas["keywords"] = 'reiser4,livecd,live-cd,live,cd,linux,truecrypt'
		end

		headAppend = Array.new
		# Insert the title meta (standalone tag)
		headAppend << "<title>" + metas["title"] + "</title>"
		# Append default metas
		metas.each do | key, value |
			headAppend << "<meta name=\"" + key + "\" content=\"" + value + "\">"
		end

		# Add other non-standard metas to the hash
		metas["url"] = @config[:base_url] + @item.identifier

		if @item[:kind] && @item[:kind] == "article"
			metas["type"] = "article"
		elsif @item.identifier == '/'
			metas["type"] = "blog"
		else
			metas["type"] = "website"
		end

		metas["image"] = @site.config[:base_url] + '/assets/img/logo.png'
		metas["fb_admins"] = "fabio.scaccabarozzi2"

		# Append OpenGraph (Facebook mainly) metas
		headAppend << "<meta name=\"og:title\" content=\"" + metas["title"] + "\">"
		headAppend << "<meta name=\"og:description\" content=\"" + metas["description"] + "\">"
		headAppend << "<meta name=\"og:url\" content=\"" + metas["url"] + "\">"
		headAppend << "<meta name=\"og:type\" content=\"" + metas["type"] + "\">"
		headAppend << "<meta name=\"og:image\" content=\"" + metas["image"] + "\">"
		headAppend << "<meta name=\"fb:admins\" content=\"" + metas["fb_admins"] + "\">"

		# Append Twitter metas
		headAppend << "<meta name=\"twitter:card\" content=\"summary\">"
		headAppend << "<meta name=\"twitter:url\" content=\"" + metas["url"] + "\">"
		headAppend << "<meta name=\"twitter:title\" content=\"" + metas["title"] + "\">"
		headAppend << "<meta name=\"twitter:description\" content=\"" + metas["description"] + "\">"
		headAppend << "<meta name=\"twitter:image\" content=\"" + metas["image"] + "\">"

		return headAppend.join("\n");
	end

end
