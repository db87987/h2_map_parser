class Map
  attr_reader :path, :title, :description, :difficulty, :size, :players, :humans, :computers

  def initialize(path)
    @path = path
    @file = File.read(path);
    # magic_byte = file.unpack("N").first
    # raise "Incorrect map file" unless magic_byte == 1543503872
  end

  def title
    @file.unpack("x58Z*").first
  end

  def description
    @file.unpack("x118Z*").first
  end

  def difficulties
    {
      0 => "Easy",
      1 => "Normal",
      2 => "Hard",
      3 => "Expert",
    }
  end

  def difficulty
    level = @file.unpack("x4S").first
    difficulties[level]
  end

  def width
    @file.unpack("x6C").first
  end

  # def height
  #   @file.unpack("x7C").first
  # end

  def sizes
    {
      36 => "S",
      72 => "M",
      108 => "L",
      144 => "XL",
    }
  end

  # def kingdom_colors
  #   colors.each_with_object([]).with_index do |(enabled, memo), index|
  #     memo << color_by_index[index] if enabled == 1
  #   end
  # end

  # def color_by_index
  #   {
  #     0 => "Blue",
  #     1 => "Green",
  #     2 => "Red",
  #     3 => "Yellow",
  #     4 => "Orange",
  #     5 => "Purple",
  #   }
  # end

  def size
    sizes[width]
  end

  # def colors
  #   @file.unpack("x8C6")
  # end

  def players
    @file.unpack("x8C6").reject { |n| n == 0 }.count
  end

  def humans
    @file.unpack("x14C6").reject { |n| n == 0 }.count
  end

  def computers
    @file.unpack("x20C6").reject { |n| n == 0 }.count
  end

  def attributes
    # [title, description, difficulty]
    {
      title: title,
      description: description,
      difficulty: difficulty,
      size: size,
      players: players,
      humans: humans,
      computers: computers,
      file: path
    }
  end
end


# // 0x6       6     Width               1 byte
# // 0x7       7     Height              1 byte
# // 0x8       8     KingdomColors       6 bytes
# // 0xE      14     AllowHumanColors    6 bytes
# // 0x14     20     AllowAIColors       6 bytes
# // 0x1A     26     _ (Kingdom Count?)  3 bytes
# // 0x1D     29     VictoryConditions   1 byte
# // 0x1E     30     AIAlsoWins          1 byte
# // 0x1F     31     AllowNormalVictory  1 byte
# // 0x20     32     VictoryData1        2 bytes
# // 0x22     34     LossConditions      1 byte
# // 0x23     35     LossData1           2 bytes
# // 0x25     37     StartWithHeroes     1 byte
# // 0x26     38     Races               6 bytes
# // 0x2C     44     VictoryData2        2 bytes
# // 0x2e     46     LossData2           2 bytes
# // 0x30     48     _                   10 bytes
# // 0x3A     58     Name                16 bytes
# // 0x4A     74     _                   44 bytes
# // 0x76    118     Description         143 bytes
# // 0x105   261     _                   159 bytes
# // 0x1A4   420     Width (duplicate)   4 bytes
# // 0x1A8   424     Height (duplicate)  4 bytes

# 2.6.2 :004 > str.unpack("N")
#  => [1543503872]