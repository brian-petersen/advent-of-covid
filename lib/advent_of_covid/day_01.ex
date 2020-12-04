defmodule AdventOfCovid.Day01 do
  def fix_report(factors, sum) do
    case find_factors_of_sum(factors, sum) do
      {a, b} -> a * b
      other -> other
    end
  end

  def find_factors_of_sum(factors, sum) do
    for a <- factors,
        b <- factors do
      if a + b == sum do
        throw({a, b})
      end
    end
  catch
    factors -> factors
  end

  def fix_report2(factors, sum) do
    case find_factors_of_sum2(factors, sum) do
      {a, b, c} -> a * b * c
      other -> other
    end
  end

  def find_factors_of_sum2(factors, sum) do
    for a <- factors,
        b <- factors,
        c <- factors do
      if a + b + c == sum do
        throw({a, b, c})
      end
    end
  catch
    factors -> factors
  end
end
