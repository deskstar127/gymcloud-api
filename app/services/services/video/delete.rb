module Services
module Video

class Delete < BaseService

  def run
    delete
  end

  def input_params
    [:video]
  end

  def delete
    vimeo_id = @video.vimeo_id
    VimeoVideoDeleteWorker.perform_async(vimeo_id) if vimeo_id

    cleanup_related
    @video.destroy!
  end

  def cleanup_related
    ActiveRecord::Base.transaction do
      @video.exercises.each do |exercise|
        clean_personal(::Exercise, exercise.video_url)
        cleanup_model(exercise)
      end
      @video.workout_templates.each do |workout|
        clean_personal(::PersonalWorkout, workout.video_url)
        cleanup_model(workout)
      end
    end
  end

  def cleanup_model(model)
    model.update_columns(
      video_url: nil,
      video_id: nil
    )
  end

  def clean_personal(klass, url)
    klass.where(video_url: url).update_all(video_url: nil)
  end

end

end
end
