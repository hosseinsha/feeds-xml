
# XML Product Feed Processor

A Ruby application to process an XML product feed, batch the products into JSON arrays based on size constraints, and send them to an external service.

## Features

- Parses XML feeds using configurable namespaces.
- Validates and extracts product data (e.g., `id`, `title`, `description`).
- Batches products into groups with a configurable size limit (default: 5 MB).
- Sends batches to an external service in JSON format.
- Includes robust error handling and logging for invalid products or files.

## Requirements

- Ruby 2.x or later
- Bundler

## Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/hosseinsha/feed-processor.git
   cd feed-processor
   ```

2. Install dependencies:

   ```bash
   bundle install
   ```

## Usage

1. Place the XML feed file in the project directory or provide its absolute path.

2. Run the processor:

   ```bash
   ruby assignment.rb path/to/feed.xml
   ```

   Replace `path/to/feed.xml` with the path to your XML feed file.

3. Example output:

   ```plaintext
   Extracted 10 valid products from XML
   Received batch of size: 5120 bytes with 5 products
   Processed and sent 2 batches
   ```

## Example XML Feed

Here’s an example of an XML feed that the processor can handle:

```xml
<rss version="2.0" xmlns:g="http://base.google.com/ns/1.0">
  <channel>
    <item>
      <g:id>123</g:id>
      <title>Sample Product</title>
      <description>Sample description.</description>
    </item>
    <item>
      <g:id>124</g:id>
      <title>Another Product</title>
      <description>Another description.</description>
    </item>
  </channel>
</rss>
```

## Project Structure

```
.
├── assignment.rb          # Entry point for the application
├── batch.rb               # Manages a single batch of products
├── product.rb             # Represents a single product
├── batch_manager.rb       # Handles batch lifecycle
├── batch_processor.rb     # Orchestrates multiple batches
├── batch_sender.rb        # Sends batches to the external service
├── product_feed_processor.rb # End-to-end processing logic
├── xml_parser.rb          # Parses and validates XML feeds
└── README.md              # Documentation
```

## Testing

1. Ensure you have RSpec installed:

   ```bash
   gem install rspec
   ```

2. Run tests (if implemented):

   ```bash
   rspec
   ```

## Customization

- **Batch Size Limit**: Modify the default batch size in `assignment.rb` by changing the `batch_size_limit` argument:

  ```ruby
  batch_processor = BatchProcessor.new(batch_size_limit: 1024 * 1024) # 1 MB limit
  ```

- **XML Namespace**: Update the `namespace` argument in `XMLParser` initialization to match your XML feed structure.
