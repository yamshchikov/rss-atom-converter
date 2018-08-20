class Converter
  def initialize(options)
    @options = options
  end

  def convert(data)
    @data = data
    if @options['sort']
      self.sort
    end
    if @options['reverse']
      self.reverse
    end
    @data
  end

  # TODO: change reverse and sort methods according to hash structure
  def reverse
    if @data.feed_type == 'rss'
      @data.items.reverse!
    else
      @data.entries.reverse!
    end
  end

  def sort
    if @data.feed_type == 'rss'
      @data.items.sort! {|a, b| a.pubDate <=> b.pubDate}
    else
      @data.entries.sort! {|a, b| a.published.content <=> b.published.content}
    end
  end
end
