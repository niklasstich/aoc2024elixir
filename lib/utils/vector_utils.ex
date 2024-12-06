defmodule Utils.Vector do

  def flip({x,y}), do: {x*-1,y*-1}

  def x_part({x,_}), do: x
  def y_part({_,y}), do: y

  def rotate_90deg({x,y}), do: rotate({x,y}, :math.pi/2)
  def rotate_90deg_ccw({x,y}), do: rotate({x,y}, -:math.pi/2)
  def rotate({x,y}, deg), do: {x*:math.cos(deg)-y*:math.sin(deg), x*:math.sin(deg)+y*:math.cos(deg)}
  def rotate_rounded({x,y}, deg) do
    {x,y} = rotate({x,y},deg)
    {round(x), round(y)}
  end

  def vector_add_int({x1,y1}, {x2, y2}), do: {x1+x2,y1+y2}
end
