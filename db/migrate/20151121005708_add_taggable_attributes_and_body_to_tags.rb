class AddTaggableAttributesAndBodyToTags < ActiveRecord::Migration
  def change
    add_column :tags, :taggable_id, :integer
    add_column :tags, :taggable_type, :string
    add_column :tags, :body, :string
  end
end
