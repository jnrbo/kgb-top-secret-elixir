import Config

config :kgb,
       :base_url,
       "https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page"

config :kgb, :url_filter, "/?filter=&__optvLead=3#link"
config :kgb, :max_pages, 5

if Mix.env() == :test do
  import_config "test.exs"
end
