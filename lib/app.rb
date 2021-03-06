require_rel 'reader'
class App
  READERS_ARRAY = [Readers::FileReader].freeze

  def initialize(options)
    @options = options
    @readers = READERS_ARRAY + (options['readers'] || [])
  end

  def run(source)
    reader_class = reader_factory(source)
    data = reader_class.read(source)

    parsed_data = ParseHelper.parse(data)

    handler = HandlerHelper.new({ sort: @options['sort'], reverse: @options['reverse'] }.compact)
    processed_data = handler.process(parsed_data)

    converter = converter_factory(@options['output_format'])
    result = converter.convert(processed_data)

    STDOUT.puts(result)
  end

  def reader_factory(source)
    @readers.find { |reader| reader.can_work?(source) }
  end

  def converter_factory(output_format)
    converter_class = Converter.constants.find { |converter| Converter.const_get(converter).can_convert?(output_format) }
    Converter.const_get(converter_class).new
  end
end
