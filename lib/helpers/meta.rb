module Meta

	def getMetasForHead()
		headAppend = Array.new
		metas = Hash.new
		metas["author"] = 'Fabio Scaccabarozzi'
		metas["generator"] = 'nanoc'
      item_title = nil

      if @item[:title]
          item_title = @item[:title] + " | " + @config[:site_name]
      else
          item_title = @config[:site_name] + " - " + @config[:claim_text]
      end

		if @item[:metatitle]
			item_title = @item[:metatitle] + " | " + @config[:site_name]
		end
      headAppend << "\n<title>" + item_title + "</title>"
		
		if @item[:desc]
			metas["description"] = @item[:desc]
		else
			metas["description"] = 'Linux projects for power users: reiser4+truecrypt enabled liveCDs, custom Gentoo overlays, linux guides and scripts.'
		end

		# Insert the title meta (standalone tag)
		headAppend << "\n<title>" + item_title + "</title>"
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

		metas["image"] = @config[:base_url] + '/assets/img/logo.png'
		metas["fb_admins"] = "fabio.scaccabarozzi2"

		# Append OpenGraph (Facebook mainly) metas
		headAppend << "<meta name=\"og:title\" content=\"" + item_title + "\">"
		headAppend << "<meta name=\"og:description\" content=\"" + metas["description"] + "\">"
		headAppend << "<meta name=\"og:url\" content=\"" + metas["url"] + "\">"
		headAppend << "<meta name=\"og:type\" content=\"" + metas["type"] + "\">"
		headAppend << "<meta name=\"og:image\" content=\"" + metas["image"] + "\">"
		headAppend << "<meta name=\"fb:admins\" content=\"" + metas["fb_admins"] + "\">"

		# Append Twitter metas
		headAppend << "<meta name=\"twitter:card\" content=\"summary\">"
		headAppend << "<meta name=\"twitter:url\" content=\"" + metas["url"] + "\">"
		headAppend << "<meta name=\"twitter:title\" content=\"" + item_title + "\">"
		headAppend << "<meta name=\"twitter:description\" content=\"" + metas["description"] + "\">"
		headAppend << "<meta name=\"twitter:image\" content=\"" + metas["image"] + "\">"

		return headAppend.join("\n");
	end

end
