defmodule Utils.Vector do

  def flip({x,y}), do: {x*-1,y*-1}

  def x_part({x,y}), do: x
  def y_part({x,y}), do: y

  def rotate_90deg({x,y}), do: rotate({x,y}, :math.pi/2)
  def rotate_90deg_ccw({x,y}), do: rotate({x,y}, -90)
  def rotate({x,y}, deg), do: {:math.cos(deg*x)-:math.sin(deg*y), :math.sin(deg*x)+:math.cos(deg*y)}
  def rotate_rounded({x,y}, deg) do
    {x,y} = rotate({x,y},deg)
    {round(x), round(y)}
  end

  def vector_add_int({x1,y1}, {x2, y2}), do: {x1+x2,y1+y2}
end
