class TrianglesController < ApplicationController

  # GET /triangles
  def calculate
    render json: {result: define_type}
  end

  def define_type
    if not is_numeric? params[:a] or not is_numeric? params[:b] or not is_numeric? params[:c]
      return TriangleType::INCORRECT
    end
    a, b, c = [params[:a].to_i, params[:b].to_i, params[:c].to_i].sort
    return TriangleType::INCORRECT if a <= 0 or a + b <= c
    return TriangleType::EQUILATERAL if a == c
    return TriangleType::ISOSCELES if a == b or b == c
    return TriangleType::SCALENE
  end

  private
    def is_numeric?(obj)
      obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) != nil
    end
end
