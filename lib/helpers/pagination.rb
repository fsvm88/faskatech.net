module Pagination

	def paginate_articles
		# Get all the articles
		articles_to_paginate = sorted_articles
		
		# Split the list into sub-arrays
		article_groups = []
		while not articles_to_paginate.empty?
			article_groups << articles_to_paginate.slice!(0..(@config[:page_size]-1))
		end

		last_article_is = article_groups.count-1

		# Generate pages for each individual sub-list
		article_groups.each_with_index do | subarticles, i |
			first = i*@config[:page_size] + 1
			last = (i+1)*@config[:page_size]

			@items << Nanoc::Item.new(
				"<%= render 'paginated_posts' %>",
				{
					:item_id => i,
					:last_id => last_article_is,
					:first => first,
					:last => last,
					:page => i+1
				},
				"/pages/#{i+1}"
			)
		end
	end

	def get_older_link(id, last)
		if (id == last) or (id+2 > last+1)
			return ""
		else
			return "/pages/#{id+2}"
		end
	end

	def get_newer_link(id)
		if (id == 0)
			return ""
		elsif (id == 1)
			return "/"
		else
			return "/pages/#{id}"
		end
	end

	# Nanoc helper to display blog post summary and a link to the full post.
	# Used inside <% sorted_articles.each do |item| %>...<% end %> block etc.
	# 
	# @example Put the following in your layout:
	# 
	#    <%= article_summary(item,'Read the full article>>') %>
	#    
	# To customize the link text you can add 'read_more' attribute to your
	# item metadata or pass the string to the helper, as above.
	# 
	# Add <!--MORE--> separator somewhere in your item to split it. Otherwise
	# the full article text is displayed.
	#
	# @param [String] item The blog post
	#
	# @param [String] read_more_text The 'Read more...' text
	#
	# @param [String] separator Separates item summary from item body. Defaults to <!--MORE-->
	#
	def article_summary(item, read_more_text="Read more...", separator="<!--MORE-->")
		summary,body = item.compiled_content.split(separator)
		return item.compiled_content unless body
		link = link_to( (item[:read_more] || read_more_text), item.path, :class=>'readmore' )
		return summary+"<p class='readmore'>#{link}</p>"
	end
end
