defmodule KGB do
  def request(page) do
    with {:ok, %HTTPoison.Response{body: body, status_code: 200}} <- HTTPoison.get("#{url}#{page}#{filter}") do
      process(body)
    else
      error ->
        Logger.error("Error while getting organization details from Website: #{inspect(error)}")
        nil
    end
  end

  def process(body) do
    IO.puts(body)
  end

  def url do
    Application.fetch_env!(:kgb, :base_url)
  end

  def filter do
    Application.fetch_env!(:kgb, :url_filter)
  end
end
