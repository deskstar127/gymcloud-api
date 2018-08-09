module GymcloudAPI::V2
module Namespaces

class Comments < Base

namespace :comments do

  desc 'Create Comment'
  params do
    requires :title, type: String, default: ''
    requires :comment, type: String
    requires :commentable_id, type: Integer
    requires :commentable_type, type: String
    requires :role, type: String, default: 'comments'
  end
  post do
    comment = ::Comment.new(
      filtered_params_with(user: current_user)
    )
    authorize!(:create, comment)
    comment.save!
    if comment.commentable_type == 'WorkoutEvent'
      recipient =
        if current_user.pro?
          comment.commentable.person
        else
          comment.commentable.personal_workout.workout_template.user
        end
      HtmlMailer.delay.comment_added(recipient.id, comment.id)
    end
    comment.create_activity(
      action: :create,
      owner: current_user,
      recipient: recipient
    )
    present(comment, with: Entities::Comment)
  end

  params do
    requires :id, type: Integer, desc: 'Comment ID'
  end
  route_param :id do

    desc 'Read Comment'
    get do
      comment = ::Comment.find(params[:id])
      authorize!(:read, comment)
      present comment, with: Entities::Comment
    end

    desc 'Update Comment'
    params do
      optional :title, type: String
      optional :comment, type: String
    end
    patch do
      comment = ::Comment.find(params[:id])
      comment.assign_attributes(filtered_params)
      authorize!(:update, comment)
      comment.save!
      present comment, with: Entities::Comment
    end

    desc 'Delete Comment'
    delete do
      comment = ::Comment.find(params[:id])
      authorize!(:destroy, comment)
      comment.destroy
      present(comment, with: Entities::Comment)
    end

  end

end

end

end
end
