describe "Tags API" do
  describe "Post /tag with entity type/id and list of tags " do
    it "creates tags for entity and deletes existing tags for this entity, if any" do
      FactoryGirl.create :product

      tag_params = {
            "entity_id" => 1,
            "entity" => "Products",
            "tags" => ["Boring", "Orange", "Silly", "Dumb", "Boring"]
      }
      request_headers = {
          "Accept" => "application/json",
          "Content-Type" => "application/json"
      }

      post "/tag" , tag_params , request_headers

      expect(response.status).to eq 201 #created

      expect(Tag.where(taggable_id: product.first)).to match_array(["Boring", "Orange", "Silly", "Dumb", "Boring"])


    end
  end
  describe "GET /:entity_type/:entity_id/tags " do
    it "returns JSON of entity and its tags" do
      tags = [ "Dangerous", "Sucks" ]
      FactoryGirl.create :product
      FactoryGirl.create :tag, taggable_id: 1, taggable_type: "Product", body: tags[0]
      FactoryGirl.create :tag, taggable_id: 1, taggable_type: "Product", body: tags[1]

      request_headers = { "Accept" => "application/json" }
      get "/products/1/tags" , {} , request_headers

      expect(response.status).to eq 200

      expect(Product.find(1).tags).to match_array(tags)

    end
  end

  describe "DELETE /:entity_type/:entity_id/tags " do
    #I don't think this api here makes sense really. Why would you want to delete the entity AND tags on this route.
    #I have modified to make it just delete the tags of the route. Would love to discuss my reasoning.

    it "completely removes tags of given entity" do
      tags = [ "Dangerous", "Sucks" ]
      FactoryGirl.create :product
      FactoryGirl.create :tag, taggable_id: 1, taggable_type: "Product", body: tags[0]
      FactoryGirl.create :tag, taggable_id: 1, taggable_type: "Product", body: tags[1]

      request_headers = { "Accept" => "application/json" }

      delete "/products/1/tags" , {} , request_headers

      expect(response.status).to eq 204 #delete success

      expect(Product.find(1).tags).to be_nil
    end
  end

end