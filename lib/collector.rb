require 'csv'

class Collector
  def self.write_to_csv
    CSV.open("lib/collection.csv", "wb") do |csv|
      csv << ["Title", "Description", "Difficulty"]

      maps.each do |map|
        csv << map.attributes
      end

      "#{maps.count} were processed!"
    end
  end

  def self.maps
    map_file_paths.map do |path|
      Map.new(path)
    end
  end

  def self.map_file_paths
    Dir["lib/maps/*"]
  end
end