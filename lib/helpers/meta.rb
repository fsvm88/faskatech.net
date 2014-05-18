#module Meta
#
#	def get_meta_line(item)
#		metas = [ :head =>
#	end
#
#	def get_post_start(post)
#		content = post.compiled_content
#		if content =~ /\s<!-- more -->\s/
#			content = content.partition('<!-- more -->').first +
#			"<div class='read-more'><a href='#{post.path}'>Continue reading &rsaquo;</a></div>"
#		end
#		return content
#	end
#
#end
