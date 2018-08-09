module Services
module GroupAssignment

class Program < BaseService

  def run
    create_personal
  end

  def input_params
    [:template, :group, :pro, :create_activities]
  end

  def defaults
    {create_activities: false}
  end

  def build_personal
    service = Services::PersonalAssignment::Program.new(
      template: @template,
      user: @group.clients.first
    )
    service.build_personal
  end

  private

  def create_personal
    ids = assigned_client_ids
    users = @group.clients.where { id << ids }
    users.map do |user|
      program = Services::PersonalAssignment::Program.!(
        template: @template,
        user: user
      )
      create_activity_for(program) if @create_activities
      program
    end
  end

  def assigned_client_ids
    ::PersonalProgram
      .assigned_by(@pro)
      .where(program_template: @template)
      .pluck(:person_id)
      .to_a
  end

  def create_activity_for(program)
    program.create_activity(
      action: :create,
      owner: @pro,
      recipient: program.person
    )
  end

end

end
end
