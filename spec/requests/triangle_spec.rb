require 'rails_helper'

RSpec.describe "/triangles", type: :request do

  describe "GET /calculate" do

    it "renders a successful response" do
        get triangles_url("10","10","10"), as: :json
        expect(response).to be_successful
        expect(response.body).to eq({result: TriangleType::EQUILATERAL}.to_json)
    end

    it "renders a successful response (Isosceles)" do
      get triangles_url("10","15","10"), as: :json
      expect(response).to be_successful
      expect(response.body).to eq({result: TriangleType::ISOSCELES}.to_json)
    end

    it "renders a successful response (Scalene)" do
      get triangles_url("10","25","30"), as: :json
      expect(response).to be_successful
      expect(response.body).to eq({result: TriangleType::SCALENE}.to_json)
    end

    # A triangle can't have the longest side greater than or equal to the sum of the other two sides
    it "renders a unsuccessful response (Incorrect)" do
      get triangles_url("10", "10", "20"), as: :json
      expect(response).to be_successful
      expect(response.body).to eq({result: TriangleType::INCORRECT}.to_json)
    end

    it "renders a unsuccessful response (Incorrect)" do
        get triangles_url("a", "b", "c"), as: :json
        expect(response).to be_successful
        expect(response.body).to eq({result: TriangleType::INCORRECT}.to_json)
    end
  end
end