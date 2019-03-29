class Selector
  def copy_maps
    dest_folder = "lib/desired_maps"
    desired_maps.each do |map|
      begin
        FileUtils.cp(map.path, dest_folder)
      rescue => e
        e.message
      end
    end
    "#{desired_maps.count} were copied"
  end

  def desired_maps
    maps.select do |map|
      map.difficulty == "Hard" && desired_sizes.include?(map.size) && map.humans > 1
    end
  end

  def desired_sizes
    ["M", "L", "XL"]
  end

  def maps
    @maps ||= begin
      map_file_paths.map do |filename|
        Map.new(filename)
      end
    end
  end

  def map_file_paths
    Dir["lib/maps/*"]
  end
end
