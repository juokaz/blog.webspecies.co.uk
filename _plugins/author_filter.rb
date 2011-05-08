module Author
  def author(input)
    author = input.downcase.sub(" ", "-") + '.html'
    return File.read(File.join('_includes', 'author_' + author))
  end
end

Liquid::Template.register_filter(Author)
