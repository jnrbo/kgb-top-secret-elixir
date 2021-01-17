defmodule KGB.ScraperTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes")
    :ok
  end

  setup_all do
    HTTPoison.start()
  end

  test "extract reviews and flatten list" do
    use_cassette "dealerpage02" do
      reviews = KGB.Scraper.call()

      assert length(reviews) == 20
    end
  end

  test "extract reviews" do
    use_cassette "dealerpage01" do
      reviews = KGB.Scraper.extract_reviews(1)

      assert length(reviews) == 10

      assert Enum.at(reviews, 0) == %{
               rate: 0.0,
               review:
                 "This dealership is absolutely amazing. Very friendly people, didn’t take long at all. Got us in a 2019 Dodge Grand Caravan. Would definitely recommend. ",
               user: "Chevyandrews04"
             }
    end
  end
end
