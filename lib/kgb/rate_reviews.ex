defmodule KGB.RateReviews do
  def words do
    %{
      very: 0.2,
      want: 0.2,
      great: 0.3,
      really: 0.3,
      highly: 0.4,
      best: 0.4,
      awesome: 0.5,
      amazing: 0.5,
      super: 0.6,
      extremely: 0.6
    }
  end

  def top_reviews(reviews) do
    top =
      Enum.map(reviews, fn review ->
        %{review | rate: calculate_rate(review.review)}
      end)

    top
    |> Enum.sort(&(&1.rate > &2.rate))
    |> Enum.take(3)
  end

  def occurrences_rate(text, word) do
    {key, weight} = word

    qnt =
      text
      |> String.split(Atom.to_string(key))
      |> length()

    (qnt - 1) * weight
  end

  def calculate_rate(text) do
    low_text = String.downcase(text)

    score =
      Enum.reduce(words(), 0.0, fn word, acc ->
        occurrences_rate(low_text, word) + acc
      end)

    Float.round(score * :math.sqrt(String.length(text) * 0.1), 4)
  end

  # coveralls-ignore-start
  def show_ranking(tops) do
    Enum.each(tops, fn rev ->
      IO.puts("User: #{rev.user} (IP: #{ip()})")
      IO.puts("Rate: #{rev.rate}")
      IO.puts("Review: #{rev.review}\n\n")
    end)
  end

  defp ip() do
    "#{Enum.random(1..255)}.#{Enum.random(0..255)}.#{Enum.random(0..255)}.#{Enum.random(0..255)}"
  end

  # coveralls-ignore-stop
end
