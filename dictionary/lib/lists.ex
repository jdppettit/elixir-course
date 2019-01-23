defmodule Lists do
  def sum([]), do: 0
  def sum([h|t]), do: h + sum(t)

  def square([]), do: []
  def square([h|t]), do: [h*h | square(t)]

  def sum_pairs([]), do: []
  def sum_pairs([ h1, h2 | t]), do: [ h1 + h2 | sum_pairs(t) ]
  
end
