Fabrication.configure do |config|
  config.fabricator_path = '/spec/fabricators'
  config.path_prefix = Dir.pwd
  config.sequence_start = 10_000
end
