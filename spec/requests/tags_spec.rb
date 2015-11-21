describe "Tags API" do
  describe "Post /tag with entity type/id and list of tags " do
    it "creates tags for entity and deletes existing tags for this entity, if any" do

    end
  end
  describe "GET /:entity_type/:entity_id/tags " do
    it "returns JSON of entity and its tags" do

    end
  end

  describe "DELETE /:entity_type/:entity_id/tags " do
    #I don't think this api here makes sense really. Why would you want to delete the entity AND tags on this route.
    #I have modified to make it just delete the tags of the route. Would love to discuss my reasoning.

    it "completely removes tags of given entity" do

    end
  end

end