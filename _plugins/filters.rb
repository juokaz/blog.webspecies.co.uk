module Jekyll
  module Filters
    def summarize(str, splitstr = '<!--more-->')
      return _strip_html(str.split(splitstr)[0], ['a','p','strong','em'])
    end
    def description(str, splitstr = '<!--more-->')
      return Maruku.new(str.split(splitstr)[0]).to_html.gsub(/<\/?[^>]*>/, "").strip
    end
    def _strip_html(str, allowed = ['a','p','img','br','i','b','u','ul','li'])
      return str.gsub(/<(\/|\s)*[^(#{allowed.join('|') << '|\/'})][^>]*>/,'')
    end
  end
end
