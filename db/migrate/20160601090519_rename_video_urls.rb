class RenameVideoUrls < ActiveRecord::Migration

  def up
    [Exercise, WorkoutTemplate, PersonalWorkout]
      .each do |klass|
        klass
          .where{video_url =~ 'http:%'}
          .each do |model|
            model.video_url.gsub!(/http:/, 'https:')
            model.save!
          end
      end
  end

end
