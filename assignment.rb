# frozen_string_literal: true

Dir[File.join(__dir__, 'lib/**/*.rb')].sort.each { |file| require_relative file }

require 'pry'
require 'active_support'
require 'active_support/core_ext'
ONE_MEGA_BYTE = 1_048_576.0

if __FILE__ == $PROGRAM_NAME
  begin
    file_path = ARGV[0] || 'default_path_to_file.xml'
    batch_size = (ARGV[1] || 5).to_i

    puts "Processing file: #{file_path}"

    parser = XMLParser.new(file_path: file_path)
    batch_processor = BatchProcessor.new(batch_size_limit: batch_size * ONE_MEGA_BYTE)
    sender = BatchSender.new(service: ExternalService.new)

    processor = ProductFeedProcessor.new(
      parser: parser,
      sender: sender,
      batch_processor: batch_processor
    )

    processor.process
    puts 'Processing completed successfully'
  rescue StandardError => e
    puts "Error during processing: #{e.message}"
    puts e.backtrace
  end
end
