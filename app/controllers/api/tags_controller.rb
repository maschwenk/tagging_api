class Api::TagsController < ActionController::API
  def create
    entity_id = params[:entity_id]
    taggable_resource = find_taggable_resource params[:entity] , entity_id
    if taggable_resource and is_taggable? taggable_resource
      if taggable_resource.tags
        taggable_resource.tags.destroy_all
      end
      params[:tags].each_with_index do |data, index|
        taggable_resource.tags.create({ body: data, taggable_id: entity_id })
      end
      render :json => { message: "Successfully created tag" }, status: 201
    end
  end

  def index
    #can skip the taggable check here, if routes are good, we can be sure that these are valid
    #but, if we want to be careful we can do this seperately
    tags = get_entity_by_url.tags
    render :json => tags
  end

  def destroy_all
    if get_entity_by_url.tags
      get_entity_by_url.tags.destroy_all
      render :json => { message: "Deleted." }, status: 204
    else
      render :json => { message: "Error deleting." }, status: 500
    end
  end

  private

  #theres probably too many methods here but I can refactor a bit

  def tag_params
    params.permit(:body)
  end

  def is_taggable?(resource)
    #verify this is a taggable resource
    if resource.class.reflect_on_all_associations(:has_many).collect {|a| a.name}.include?(:tags)
      return resource
    end
  end

  def retreive_taggable_resource(entity, id)
    return entity.classify.constantize.find(id)
  end

  def get_entity_by_url
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
  end

  # def delete_entity_tags_by_url
  #   params.each do |name, value|
  #     if name =~ /(.+)_id$/
  #       $1.classify.constantize.
  #       #tags = $1.classify.constantize.tags
  #       #if tags $1.classify.constantize.tags.destroy(value)
  #     end
  #   end
  # end

  def find_taggable_resource(entity, id)
    #note, here someone could put in anything. there are a lot of approaches to handling this.
    if entity and id
      return retreive_taggable_resource entity , id
    end
  end



end
