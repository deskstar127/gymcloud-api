class SearchService

  ENTITIES = {
    exercises: Exercise,
    workouts: WorkoutTemplate,
    programs: ProgramTemplate,
    clients: User,
    client_groups: ClientGroup
  }.freeze

  attr_accessor :results

  def initialize(params = {})
    @q = params.delete(:q)
    @user_id = params.delete(:user_id)
    @entity_type = params.delete(:entity_type).try(:to_sym) || :all
    @search_scope = params.delete(:search_scope).try(:to_sym) || :all
    self
  end

  def search!
    @results = []
    entities = prepare_entires
    results = search_entities(entities, @search_scope)
    @results = entities_to_results(entities, results)
  end

  private

  def entities_to_results(entities, results)
    entities.each_with_index.map do |entity, index|
      {
        klass: ENTITIES[entity].name,
        title: entity.to_s.titleize,
        items: results[index]
      }
    end
  end

  def search_entities(entities, search_scope)
    entities.map do |entity|
      search_entity(entity, search_scope)
    end
  end

  def search_entity(entity, search_scope)
    klass = ENTITIES[entity]
    scope = find_klass_scope(klass, search_scope)
    begin
      scope.search_by_criteria(criteria) || []
    rescue ActiveRecord::StatementInvalid
      []
    end
  end

  def find_klass_scope(klass, search_scope)
    case search_scope
    when :own
      klass.owned_by(@user_id)
    when :public
      klass.public_for(@user_id)
    when :all
      klass.global_for(@user_id)
    end
  end

  def prepare_entires
    case
    when @entity_type == :all
      ENTITIES.keys
    when ENTITIES.key?(@entity_type)
      [@entity_type]
    else
      []
    end
  end

  def criteria
    "%#{@q}%"
  end

end
