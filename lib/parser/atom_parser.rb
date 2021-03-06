module Parser
  module AtomParser
    def self.parse(source)
      atom_hash = {
        title: source.title.content,
        id: source.id.content,
        updated: source.updated.content,
        author: source.author.name.content,
        items: []
      }

      source.entries.each do |entry|
        atom_hash[:items].push(
          title: entry.title.content,
          updated: entry.updated.content,
          published: entry.published.content,
          id: entry.id.content,
          link: entry.link.href
        )
      end
      atom_hash
    end
  end
end
