# coveralls-ignore-start

defmodule Mix.Tasks.Analyzes do
  use Mix.Task

  @shortdoc "Analyzes reviews."
  def run(_) do
    HTTPoison.start()

    info()

    IO.puts("Target acquired: McKaig Chevrolet Buick - A Dealer For The People ")
    IO.puts("Getting reviews... \n")

    reviews = KGB.Scraper.call()

    IO.puts("Done. Found #{length(reviews)} reviews \n")

    IO.puts("Initializing analyzes and calculating score... ")

    tops = KGB.RateReviews.top_reviews(reviews)

    IO.puts("Done.\n")


    IO.puts("TOP 3 REVIEWS:\n")

    KGB.RateReviews.show_ranking(tops)

    IO.puts("\n..................................\n")
  end

  def info do
    IO.puts("\n|--------------------------------|")
    IO.puts("|          WELCOME TO KGB        |")
    IO.puts("|          Secure System         |")
    IO.puts("|--------------------------------|\n\n")

    IO.puts("Enabling satellites...")
    Process.sleep(500)
    IO.puts("Done. \n")

    IO.puts("Installing CIA Plug-in..")
    Process.sleep(300)
    IO.puts("Done. \n")

    IO.puts("Accessing secure networking tunnel..")
    Process.sleep(750)
    IO.puts("Done. \n")

    Process.sleep(250)
    IO.puts("\n..................................\n")
  end
end

# coveralls-ignore-stop
