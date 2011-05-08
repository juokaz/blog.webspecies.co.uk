module Author
  def author(input)
    author = input.downcase.sub(" ", "-") + '.html'
    profile = File.read(File.join('_includes', 'author_' + author))
    return Maruku.new(profile).to_html.sub("<p>", "").sub("</p>", "")
  end
end

Liquid::Template.register_filter(Author)
