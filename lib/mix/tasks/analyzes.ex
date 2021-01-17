defmodule Mix.Tasks.Analyzes do
  use Mix.Task

  @shortdoc "Analyzes reviews."
  def run(_) do
    HTTPoison.start()
    #    Mix.Task.run("app.start")

    KGB.Scraper.call()
  end
end
