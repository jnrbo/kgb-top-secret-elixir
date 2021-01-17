defmodule KGB.RateReviewsTest do
  use ExUnit.Case

  test "calculates occurrences rate in text" do
    assert KGB.RateReviews.occurrences_rate("just a great text", {:great, 0.35}) == 0.35
    assert KGB.RateReviews.occurrences_rate("just a great text thats great", {:great, 0.35}) == 0.7
  end

  test "calculates rate" do
    assert KGB.RateReviews.calculate_rate("a amazing great incredible review") == 1.4533
    assert KGB.RateReviews.calculate_rate("a amazing incredible review") == 0.8216
    assert KGB.RateReviews.calculate_rate("nothing") == 0.0
  end

  test "filter and sort" do
    tops = KGB.RateReviews.top_reviews(reviews())
    test = [review3(), review2(), review1()]
    assert Enum.map(tops, fn top -> top.user end) == Enum.map(test, fn top -> top.user end)
  end

  def review1 do
    %{
      review: "just a great text",
      user: "junior_barros",
      rate: 0.0
    }
  end

  def review2 do
    %{
      review: "just a great text thats great",
      user: "moe",
      rate: 0.0
    }
  end

  def review3 do
    %{
      review: "just a super great text super great",
      user: "jr",
      rate: 0.0
    }
  end

  def review4 do
    %{
      review: "random",
      user: "jr2",
      rate: 0.0
    }
  end

  def reviews do
    [
      review1(),
      review2(),
      review3(),
      review4()
    ]
  end
end
