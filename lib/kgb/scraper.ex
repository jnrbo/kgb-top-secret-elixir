require Logger

defmodule KGB.Scraper do
  def call() do
    range = 1..max_pages()

    reviews =
      Enum.map(range, fn page ->
        page
        |> extract_reviews
      end)

    reviews
    |> Flatt.flatten()
  end

  def extract_reviews(page) do
    with {:ok, body} <- request(page) do
      reviews = reviews(body)

      Enum.map(reviews, fn review ->
        %{
          review: review_text(review),
          user: review_user(review),
          rate: 0.0
        }
      end)
    end
  end

  defp reviews(body) do
    body
    |> Floki.parse_document!()
    |> Floki.find(".review-entry")
  end

  defp review_text(review) do
    review
    |> Floki.find(".review-content")
    |> Floki.text()
  end

  defp review_user(review) do
    review
    |> Floki.find(".margin-bottom-sm span.italic.font-18")
    |> Floki.text()
    |> String.replace("- ", "")
  end

  defp request(page) do
    with {:ok, %HTTPoison.Response{body: body, status_code: 200}} <- get(page) do
      {:ok, body}
    else
      error ->
        Logger.error("Error while getting organization details from Website: #{inspect(error)}")
        {:error, nil}
    end
  end

  defp get(page) do
    "#{url()}#{page}#{filter()}"
    |> HTTPoison.get(headers())
  end

  defp headers() do
    [
      {"User-Agent", "KGB/37.26.8"}
    ]
  end

  defp url do
    Application.fetch_env!(:kgb, :base_url)
  end

  defp filter do
    Application.fetch_env!(:kgb, :url_filter)
  end

  defp max_pages do
    Application.fetch_env!(:kgb, :max_pages)
  end
end
