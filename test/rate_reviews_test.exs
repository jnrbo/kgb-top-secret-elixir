defmodule KGB.RateReviewsTest do
  use ExUnit.Case
  doctest KGB.RateReviews

  test "calculates occurrences rate in text" do
    assert KGB.RateReviews.occurrences_rate("just a great text", {:great, 0.35}) == 0.35
    assert KGB.RateReviews.occurrences_rate("just a great text thats great", {:great, 0.35}) == 0.7
  end

  test "calculates rate" do
    assert KGB.RateReviews.calculate_rate("a amazing great incredible review") == 1.45
    assert KGB.RateReviews.calculate_rate("a amazing incredible review") == 0.82
    assert KGB.RateReviews.calculate_rate("nothing") == 0.0
  end
end
