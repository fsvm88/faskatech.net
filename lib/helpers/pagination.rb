module Pagination

	def paginateArticles
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

end
