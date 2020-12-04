defmodule AdventOfCovid.Day04 do
  defmodule Passport do
    defstruct [
      :birth_year,
      :issue_year,
      :expiration_year,
      :height,
      :hair_color,
      :eye_color,
      :passport_id,
      :country_id
    ]

    @required_fields [
      :birth_year,
      :issue_year,
      :expiration_year,
      :height,
      :hair_color,
      :eye_color,
      :passport_id
    ]

    def new(fields) do
      Enum.reduce(fields, %Passport{}, fn field, passport ->
        [key, value] = String.split(field, ":")

        case key do
          "byr" -> %{passport | birth_year: value}
          "iyr" -> %{passport | issue_year: value}
          "eyr" -> %{passport | expiration_year: value}
          "hgt" -> %{passport | height: value}
          "hcl" -> %{passport | hair_color: value}
          "ecl" -> %{passport | eye_color: value}
          "pid" -> %{passport | passport_id: value}
          "cid" -> %{passport | country_id: value}
          _ -> passport
        end
      end)
    end

    def is_valid1?(%Passport{} = passport) do
      Enum.all?(@required_fields, &(Map.get(passport, &1) != nil))
    end

    def is_valid2?(%Passport{} = passport) do
      passport
      |> Map.keys()
      |> Enum.all?(&valid_field?(&1, Map.get(passport, &1)))
    end

    def valid_field?(:birth_year, year) do
      year = String.to_integer(year)
      year >= 1920 and year <= 2002
    end

    def valid_field?(:issue_year, year) do
      year = String.to_integer(year)
      year >= 2010 and year <= 2020
    end

    def valid_field?(:expiration_year, year) do
      year = String.to_integer(year)
      year >= 2020 and year <= 2030
    end

    def valid_field?(:height, height) do
      cond do
        height == nil ->
          false

        String.ends_with?(height, "cm") ->
          height = height |> String.replace("cm", "") |> String.to_integer()
          height >= 150 and height <= 193

        String.ends_with?(height, "in") ->
          height = height |> String.replace("in", "") |> String.to_integer()
          height >= 59 and height <= 76

        true ->
          false
      end
    end

    def valid_field?(:hair_color, color) do
      color && String.match?(color, ~r/^#[0-9a-f]{6}$/)
    end

    def valid_field?(:eye_color, color) do
      color in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    end

    def valid_field?(:passport_id, id) do
      id && String.match?(id, ~r/^[0-9]{9}$/)
    end

    def valid_field?(_, _) do
      true
    end
  end

  def parse_input(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&String.split(&1, ~r/[ \n]+/, trim: true))
    |> Enum.map(&Passport.new/1)
  end
end
