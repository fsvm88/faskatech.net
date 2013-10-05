module Pagination

	def paginate_articles
		# Get all the articles
		articles_to_paginate = sorted_articles
		
		# Split the list into sub-arrays
		article_groups = []
		until articles_to_paginate.empty?
			article_groups << articles_to_paginate.slice(0..@config[:page_size]-1)
		end

		# Generate pages for each individual sub-list
		article_groups.each_with_index do | subarticles, i |
			first = i*@config[:page_size] + 1
			last = (i+1)*@config[:page_size]

			@items << Nanoc::Item.new(
				,
				{
					:title => "",
					:first => first,
					:last => last,
					:page => i+1,
				},
				"/pages/#{i+1}"
			)
		end
	end

end
