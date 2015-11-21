class Api::StatsController < ActionController::API

  def show_all
    tags_by_count = Tag.all.group(:body).count
    tags_by_count = tags_by_count.map do |tag_name, count|
      { tag: tag_name, count: count }
    end
    render json: tags_by_count
  end

  def index
    entity        = get_entity_by_url
    tags_by_count = Tag.where(taggable_id: entity.id).group(:body).count
    tags_by_count = tags_by_count.map do |tag_name, count|
      { tag: tag_name, count: count }
    end
    render json: tags_by_count
  end

  def get_entity_by_url
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
  end
end