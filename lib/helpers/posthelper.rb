module PostHelper

	def getPrettyDate(post)
		attribute_to_time(post[:created_at]).strftime('%B %-d, %Y')
	end

	def getMachineDate(post)
		attribute_to_time(post[:created_at]).strftime('%Y-%m-%d')
	end

	# Nanoc helper to display blog post summary and a link to the full post.
	# Used inside <% sorted_articles.each do |item| %>...<% end %> block etc.
	# 
	# @example Put the following in your layout:
	# 
	#    <%= articleSummary(item,'Read the full article>>') %>
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
	def articleSummary(item, read_more_text="Read more...", separator="<!--MORE-->")
		summary,body = item.compiled_content.split(separator)
		return item.compiled_content unless body
		link = link_to( (item[:read_more] || read_more_text), item.path, :class=>'readmore' )
		return summary+"<p class=\"readmore\">#{link}</p>"
	end

end
