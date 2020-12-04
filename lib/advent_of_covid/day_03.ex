defmodule AdventOfCovid.Day03 do
  defmodule WorldMap do
    defstruct [:map, :rows, :cols]

    def open(), do: "."
    def tree(), do: "#"

    def new(map) do
      rows = length(map)
      cols = length(hd(map))

      %WorldMap{map: map, rows: rows, cols: cols}
    end

    def at(%WorldMap{rows: rows}, row, _col) when row > rows do
      open()
    end

    def at(%WorldMap{map: map, cols: cols}, row, col) do
      # world map repeats to the right
      col = rem(col, cols)

      map
      |> Enum.at(row)
      |> Enum.at(col)
    end
  end

  def parse_input(input) do
    map =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.graphemes/1)

    WorldMap.new(map)
  end

  def count_trees_to_bottom(map, down, right) do
    do_count(map, 0, 0, down, right, 0)
  end

  defp do_count(%WorldMap{rows: rows}, row, _down, _right, _col, count) when row >= rows do
    count
  end

  defp do_count(map, row, col, down, right, count) do
    is_tree = WorldMap.at(map, row, col) == WorldMap.tree()

    do_count(map, row + down, col + right, down, right, count_tree(count, is_tree))
  end

  defp count_tree(count, false), do: count
  defp count_tree(count, true), do: count + 1
end
