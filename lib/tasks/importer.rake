desc "import a path. You define path by env variable IMPORT_PATH"
task :importer => :environment do
  require 'importer'
  Importer.new(ENV['IMPORT_PATH']).import
end
