require "rails_helper"

RSpec.describe TrianglesController, type: :routing do
  describe "routing" do
    it "routes to #triangle" do
      expect(get: "/triangle/1/2/3").to route_to("triangles#calculate", a:"1", b:"2", c:"3")
    end
  end
end