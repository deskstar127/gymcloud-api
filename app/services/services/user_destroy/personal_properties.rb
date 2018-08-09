module Services
module UserDestroy

class PersonalProperties < Base

  private

  def destroy
    @user.personal_properties.each { |prop| destroy_property(prop) }
  end

  def destroy_property(property)
    property.destroy if property.exercise_properties.empty?
  end

end

end
end
