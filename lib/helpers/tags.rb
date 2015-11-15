module Tags

	def createTagItems
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

		#:articles => sortArticlesForTagger(items_with_tag(oneTag)),
		# Generate items and append them to the items list
		all_tags.uniq.each do | oneTag |
			@items.create(
				"<%= render '/tags_page.*' %>",
				{ :tag => oneTag },
				"/tag/#{oneTag}"
			)
		end
	end

	def sortArticlesForTagger(articles)
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

	def getCorrelatedPosts()
		# Get the item tags
		postCount = Hash.new
		if @item[:tags]
			sorted_articles.each { |article|
				count = 0
				if article[:tags]
					article[:tags].each { |tag| count += 1 if @item[:tags].include?(tag) }
					postCount[count] = Array.new unless postCount[count].is_a?(Array)
					postCount[count].push(article)
				end
			}
			plausiblePosts = postCount.sort.reverse
			allPosts = Array.new
			plausiblePosts.each { | count, idAry |
				idAry.each { | element | allPosts << element unless @item.identifier == element.identifier }
			}
			return allPosts
		end
		return nil
	end
end
