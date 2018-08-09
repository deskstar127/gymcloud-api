module Services
module UserBootstrap

class PersonalProperties < BaseService

  def run
    bootstrap
  end

  def input_params
    [:user]
  end

  private

  def bootstrap
    ::GlobalProperty.all.each_with_index do |global_property, position|
      bootstrap_personal_property(global_property, position)
    end
  end

  def bootstrap_personal_property(global_property, position)
    property = ::PersonalProperty.find_or_create_by(
      global_property: global_property,
      person: @user
    )
    property.assign_attributes(
      position: position,
      is_visible: true
    )
    property.save!
  end

end

end
end
