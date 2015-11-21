describe "Stats API" do
  describe "GET /api/stats " do
    it "Retrieves statistics about all tags" do
      get "/api/stats/", {}, { "Accept" => "application/json" }
    end
  end
  describe "GET /api/stats/:entity_type/:entity_id" do
    #my logic for this route is similar, doesn't make sense for this to be stats route
    #given these stats are speicific to a given entity
    it "Retrieves statistics about a specific tagged entity" do
      FactoryGirl.create :product, name: ""
      get "/api/products/1/", {}, { "Accept" => "application/json" }
    end
  end

end