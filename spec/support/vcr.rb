VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join('spec', 'vcr')
  c.hook_into :webmock
  c.ignore_hosts '127.0.0.1', 'chromedriver.storage.googleapis.com'
end

RSpec.configure do |c|
  c.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join('/').underscore.gsub(%r{[^\w/]+}, '_')
    options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
    VCR.use_cassette(name, options) { example.call }
  end
end
