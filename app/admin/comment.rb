ActiveAdmin.register ::Comment do

  menu parent: 'Communication'

  permit_params :title, :comment,
    :commentable_id, :commentable_type, :user_id, :role

end
