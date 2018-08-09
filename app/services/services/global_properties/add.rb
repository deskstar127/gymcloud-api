module Services
module GlobalProperties

class Add < BaseService

  def run
    add
  end

  def input_params
    [:global_property]
  end

  def add
    User.all.each do |user|
      PersonalProperty.create!(
        global_property: @global_property,
        person: user
      )
    end
  end

end

end
end
