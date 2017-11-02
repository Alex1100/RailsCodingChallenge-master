class Cuboid
  attr_reader :origin, :length, :width, :height

  def initialize(origin, length, width, height)
    @origin = origin
    @length = length
    @width = width
    @height = height
  end

  #BEGIN public methods that should be your starting point
  def move_to!(x, y, z)
    #f = front
    #re = rear
    #t = top
    #b = bottom
    #l = left
    #r = right

    ## since the (ftl) front top left facing side's vertex is always
    ## the origin with my implementation, I am able to simply
    ## define the new origin and I am able to move the whole
    ## object with just two lines of code

    self.origin[0], self.origin[1], self.origin[2] = x, y, z
    self

  end

  def vertices
    #f = front
    #re = rear
    #t = top
    #b = bottom
    #l = left
    #r = right

    all_vertices = []

    #front-top-left
    ftl = self.origin
    all_vertices << ["ftl", ftl]

    #front-top-right
    ftr = [(self.origin[0] + (self.width)), self.origin[1], self.origin[2]]
    all_vertices << ["ftr", ftr]

    #front-bottom-left
    fbl = [self.origin[0], (self.origin[1] - (self.length)), self.origin[2]]
    all_vertices << ["fbl", fbl]

    #front-bottom-right
    fbr = [(self.origin[0] + (self.width)), (self.origin[1] - (self.length)), self.origin[2]]
    all_vertices << ["fbr", fbr]

    #rear-top-left
    retl = [self.origin[0], self.origin[1], (self.origin[2] - (self.length))]
    all_vertices << ["retl", retl]

    #rear-top-right
    retr = [(self.origin[0] + (self.width)), self.origin[1], (self.origin[2] - (self.length))]
    all_vertices << ["retr", retr]

    #rear-bottom-left
    rebl = [self.origin[0], (self.origin[1] - (self.length)), (self.origin[2] - (self.length))]
    all_vertices << ["rebl", rebl]

    #rear-bottom-right
    rebr = [(self.origin[0] + (self.width)), (self.origin[1] - (self.length)), (self.origin[2] - (self.length))]
    all_vertices << ["rebr", rebr]

    all_vertices

  end

  def horizontal_intersection?(other)
    ## get range of all x-axis points
    ## if there are duplicate points
    ## then return true else false

    original_x_range = []
    other_x_range = []
    combined_x_range = []

    self.origin[0].upto((self.origin[0] + self.width)){ |i| original_x_range << i }

    other.origin[0].upto((other.origin[0] + other.width)){ |i| other_x_range << i }

    combined_x_range << original_x_range
    combined_x_range << other_x_range

    if combined_x_range.flatten.uniq.length < (original_x_range.length + other_x_range.length)
      return true
    else
      return false
    end

  end

  def vertical_intersection?(other)
    ## get range of all y-axis points
    ## if there are duplicate points
    ## then return true else false

    original_y_range = []
    other_y_range = []
    combined_y_range = []

    self.origin[1].upto((self.origin[1] + self.length)){ |i| original_y_range << i }

    other.origin[1].upto((other.origin[1] + other.length)){ |i| other_y_range << i }

    combined_y_range << original_y_range
    combined_y_range << other_y_range

    if combined_y_range.flatten.uniq.length < (original_y_range.length + other_y_range.length)
      return true
    else
      return false
    end

  end

  def within_z_index_range?(other)
    ## whichever cuboid has a greater z-index
    ## take that cuboid and subtract the z-index
    ## and it's length, then return true if
    ## the other cuboid's z-index added by
    ## the other cuboid's length is greater
    ## than or equal to the first cuboid's
    ## z-index subtracted by the first cuboid's
    ## length

    if other.origin[2] > self.origin[2]
      thresh_point = other.origin[2] - other.length
      if self.length + self.origin[2] >= thresh_point
        return true
      else
        return false
      end
    elsif other.origin[2] < self.origin[2]
      thresh_point = self.origin[2] - self.length
      if other.length + other.origin[2] >= thresh_point
        return true
      else
        return false
      end
    else
      return true
    end

  end


  #returns true if the two cuboids intersect each other.  False otherwise.
  def intersects?(other)
    horizontal_intersection = self.horizontal_intersection?(other)
    vertical_intersection = self.vertical_intersection?(other)
    within_z_index_range = self.within_z_index_range?(other)

    return within_z_index_range && vertical_intersection && horizontal_intersection

  end

  def rotate(clockwise)
    if clockwise
      old_origin = self.origin
      new_origin_x, new_origin_y = self.origin[1], (self.origin[0] * -1)
      Cuboid.new([new_origin_x, new_origin_y, self.origin[2]], self.length, self.width, self.height)
    else
      old_origin = self.origin
      new_origin_x, new_origin_y = (self.origin[1] * -1), self.origin[0]
      Cuboid.new([new_origin_x, new_origin_y, self.origin[2]], self.length, self.width, self.height)
    end
  end

  #END public methods that should be your starting point
end
