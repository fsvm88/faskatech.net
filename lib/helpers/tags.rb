module Tags

	def create_tag_items
		# Get all the articles
		articles_to_paginate = sorted_articles

		# Get all available tags
		all_tags = []
		articles_to_paginate.each do | item |
			if ! item[:tags].nil?
				item[:tags].each do | tag |
					all_tags << tag
				end
			end
		end
		# Sort the array
		all_tags.sort!

		# Generate a list of items with the given tag
#		article_groups = []
#		all_tags.each do | oneTag |
#			article_groups << {
#				:tag => oneTag
#			}
#		end

		#:articles => sort_articles_for_tagger(items_with_tag(oneTag)),
		# Generate items and append them to the items list
		all_tags.each do | oneTag |
			@items << Nanoc::Item.new(
				"<%= render 'tags_page' %>",
				{ :tag => oneTag },
				"/tag/#{oneTag}"
			)
		end
	end

	def sort_articles_for_tagger(articles)
		articles.sort_by do |a|
			attribute_to_time(a[:created_at])
		end.reverse
	end

	def tags(item)
		if item[:tags].nil?
			'(none)'
		else
			item[:tags].join(', ')
		end
	end

end
