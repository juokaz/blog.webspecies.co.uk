module Jekyll
  module Filters
    def summarize(str, splitstr = '<!--more-->')
      str.split(splitstr)[0]
    end
    def description(str, splitstr = '<!--more-->')
      return Maruku.new(str.split(splitstr)[0]).to_html.gsub(/<\/?[^>]*>/, "")
    end
  end
end
