module Combiner 
    # Credits for this code go out to Jakob Laegdsmand
    # http://jakoblaegdsmand.com/blog/2012/12/minifying-js-and-css-in-nanoc/

    # Returns all JS files squashed together
    def getAllJsItems(files)
        js_arr = []
        for file in files
            item = @items.find { |i| i.identifier == "/assets/js/#{file}/" }
            puts "File #{file} doesn't exist!" unless item
            js_arr << item.compiled_content
        end
        js_arr.join("\n")
    end
    
    # Returns all CSS files squashed together
    def getAllCssItems(files)
        css_arr = []
        for file in files
            item = @items.find { |i| i.identifier == "/assets/css/#{file}/" }
            puts "File #{file} doesn't exist!" unless item
            css_arr << item.compiled_content
        end
        css_arr.join("\n")
    end

end
