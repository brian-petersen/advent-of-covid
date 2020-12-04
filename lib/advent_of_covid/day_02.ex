defmodule AdventOfCovid.Day02 do
  defmodule Policy do
    defstruct [:min, :max, :letter]
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  def password_follows_policy?({password, policy}) do
    password_follows_policy?(password, policy)
  end

  def password_follows_policy?(password, policy) do
    count =
      password
      |> String.graphemes()
      |> Enum.count(&(&1 == policy.letter))

    count >= policy.min and count <= policy.max
  end

  def password_follows_policy2?({password, policy}) do
    password_follows_policy2?(password, policy)
  end

  def password_follows_policy2?(password, policy) do
    match1 = String.at(password, policy.min - 1) == policy.letter
    match2 = String.at(password, policy.max - 1) == policy.letter

    (match1 and not match2) or (not match1 and match2)
  end

  def check_input(input) do
    input
    |> parse_input()
    |> Enum.filter(&password_follows_policy?/1)
    |> length()
  end

  def check_input2(input) do
    input
    |> parse_input()
    |> Enum.filter(&password_follows_policy2?/1)
    |> length()
  end

  defp parse_line(line) do
    [lengths, letter, password] = String.split(line, " ")

    letter = String.at(letter, 0)

    [min, max] =
      lengths
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)

    {password, %Policy{min: min, max: max, letter: letter}}
  end
end
