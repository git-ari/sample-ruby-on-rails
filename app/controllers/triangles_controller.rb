class TrianglesController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /triangle
  def calculate
    render json: {result: define_type}
  end

  def define_type
    a, b, c = [params[:a].to_i, params[:b].to_i, params[:c].to_i].sort
    return TriangleType::INCORRECT if a <= 0 or a + b <= c
    return TriangleType::EQUILATERAL if a == c
    return TriangleType::ISOSCELES if a == b or b == c
    return TriangleType::SCALENE
  end

end
