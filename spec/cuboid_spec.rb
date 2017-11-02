require_relative '../lib/cuboid'

#This test is incomplete and, in fact, won't even run without errors.
#  Do whatever you need to do to make it work and please add your own test cases for as many
#  methods as you feel need coverage
describe Cuboid do

  describe "vertices" do
    it "finds all vertices (aka edges)" do
      init_args = [[0, 0, 0], 4, 10, 4]

      subject = Cuboid.new(*init_args)

      expect(subject.vertices.class).to eq Array
      expect(subject.vertices[0][0][0].class).to eq String

      expect(subject.vertices).to eq [["ftl", [0, 0, 0]], ["ftr", [10, 0, 0]], ["fbl", [0, -4, 0]], ["fbr", [10, -4, 0]], ["retl", [0, 0, -4]], ["retr", [10, 0, -4]], ["rebl", [0, -4, -4]], ["rebr", [10, -4, -4]]]
    end
  end

  describe "move_to" do
    it "changes the origin in the simple happy case" do
      init_args = [[0,0,0], 4, 10, 4]
      subject = Cuboid.new(*init_args)

      move_args = [1, 2, 3.5]
      subject = subject.move_to!(*move_args)

      expect(subject.origin.class).to eq Array
      expect(subject.origin[0].class).to eq Integer || Float

      expect(subject.origin).not_to eq [100, 100, 10]
      expect(subject.origin).to eq move_args

      expect(subject.vertices.class).to eq Array
      expect(subject.vertices[0][0][0].class).to eq String

      expect(subject.vertices).to eq [["ftl", [1, 2, 3.5]], ["ftr", [11, 2, 3.5]], ["fbl", [1, -2, 3.5]], ["fbr", [11, -2, 3.5]], ["retl", [1, 2, -0.5]], ["retr", [11, 2, -0.5]], ["rebl", [1, -2, -0.5]], ["rebr", [11, -2, -0.5]]]
    end

    it "changes the origin in the simple happy case with higher input values" do
      init_args = [[0,0,0], 4, 10, 4]
      subject = Cuboid.new(*init_args)

      move_args = [100, 200, 300.5]
      subject = subject.move_to!(*move_args)

      expect(subject.origin.class).to eq Array
      expect(subject.origin[0].class).to eq Integer || Float

      expect(subject.origin).not_to eq [100, 100, 10]
      expect(subject.origin).to eq move_args

      expect(subject.vertices.class).to eq Array
      expect(subject.vertices[0][0][0].class).to eq String

      expect(subject.vertices).to eq [["ftl", [100, 200, 300.5]], ["ftr", [110, 200, 300.5]], ["fbl", [100, 196, 300.5]], ["fbr", [110, 196, 300.5]], ["retl", [100, 200, 296.5]], ["retr", [110, 200, 296.5]], ["rebl", [100, 196, 296.5]], ["rebr", [110, 196, 296.5]]]
    end
  end

  describe "horizontal_intersection?" do
    it "returns false if there aren't shared points along the x-axis of a 3D space between two objects" do
      args = [[0, 0, 0], 2, 4, 2]
      test_subject_args = [[5, 3, 0], 3, 5, 3]

      original_subject = Cuboid.new(*args)
      test_subject = Cuboid.new(*test_subject_args)

      expect(original_subject.horizontal_intersection?(test_subject)).to eq false
    end

    it "returns true if there are shared points along the x-axis of a 3D space between two objects" do
      args = [[0, 0, 0], 2, 4, 2]
      test_subject_args = [[4, 3, 0], 3, 5, 3]

      original_subject = Cuboid.new(*args)
      test_subject = Cuboid.new(*test_subject_args)

      expect(original_subject.horizontal_intersection?(test_subject)).to eq true
    end
  end

  describe "vertical_intersection?" do
    it "returns false if there aren't shared points along the y-axis of a 3D space between two objects" do
      args = [[0, 0, 0], 4, 4, 2]
      test_subject_args = [[5, 10, 10], 30, 50, 30]

      original_subject = Cuboid.new(*args)
      test_subject = Cuboid.new(*test_subject_args)

      expect(original_subject.vertical_intersection?(test_subject)).to eq false
    end

    it "returns true if there are shared points along the y-axis of a 3D space between two objects" do
      args = [[0, 0, 0], 4, 4, 2]
      test_subject_args = [[5, 3, 0], 3, 5, 3]

      original_subject = Cuboid.new(*args)
      test_subject = Cuboid.new(*test_subject_args)

      expect(original_subject.vertical_intersection?(test_subject)).to eq true
    end
  end

  describe "within_z_index_range?" do
    it "returns false if there aren't shared points along the z-axis of a 3D space between two objects" do
      args = [[0, 0, 0], 4, 6.5, 4]
      test_subject_args = [[10, 30, -100], 3, 5, 3]

      original_subject = Cuboid.new(*args)
      test_subject = Cuboid.new(*test_subject_args)

      expect(original_subject.within_z_index_range?(test_subject)).to eq false
    end

    it "returns true if there are shared points along the z-axis of a 3D space between two objects" do
      args = [[0, 0, 0], 4, 4, 2]
      test_subject_args = [[5, 3, 0], 3, 5, 3]

      original_subject = Cuboid.new(*args)
      test_subject = Cuboid.new(*test_subject_args)

      expect(original_subject.within_z_index_range?(test_subject)).to eq true
    end
  end

  describe "intersects?" do
    it "returns false if intersections between objects aren't found" do
      args = [[0, 0, 0], 2, 4, 2]
      test_subject_args = [[5, 3, 0], 3, 5, 3]

      original_subject = Cuboid.new(*args)
      test_subject = Cuboid.new(*test_subject_args)

      expect(original_subject.intersects?(test_subject)).to eq !!original_subject.intersects?(test_subject)
      expect(original_subject.intersects?(test_subject)).to eq false
    end


    it "returns true if intersections between objects are found" do
      args = [[0, 0, 0], 2, 4, 2]
      test_subject_args = [[4, 2, 0], 3, 5, 3]

      original_subject = Cuboid.new(*args)
      test_subject = Cuboid.new(*test_subject_args)

      expect(original_subject.intersects?(test_subject)).to eq !!original_subject.intersects?(test_subject)
      expect(original_subject.intersects?(test_subject)).to eq true
    end
  end

  describe "rotate" do
    it "rotates an object 90º counter-clockwise" do
      args = [[1, 2, 2], 2, 4, 2]

      subject = Cuboid.new(*args)
      new_subject = subject.rotate(false)

      expect(subject.origin[1]).to eq (new_subject.origin[0] * -1)
      expect(new_subject.vertices).not_to eq subject.vertices
    end

    it "rotates an object 90º clockwise" do
      args = [[1, 2, 2], 2, 4, 2]

      subject = Cuboid.new(*args)
      new_subject = subject.rotate(true)

      expect(subject.origin[0]).to eq (new_subject.origin[1] * -1)
      expect(new_subject.vertices).not_to eq subject.vertices
    end
  end

end
