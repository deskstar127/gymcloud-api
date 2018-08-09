ActiveAdmin.register PersonalProgram do

  menu parent: 'Personal'

  permit_params :name, :description, :note, :status,
    :program_template_id, :person_id

  controller do

    def create
      attributes = params[:personal_program]
      template = ::ProgramTemplate.find(attributes[:program_template_id])
      user = ::User.find(attributes[:person_id])
      service = Services::PersonalAssignment::Program.new(
        template: template,
        user: user
      )
      @personal_program = service.process.result
      super
    end

  end

end
