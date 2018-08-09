# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  title            :string(50)       default("")
#  comment          :text
#  commentable_id   :integer
#  commentable_type :string
#  user_id          :integer
#  role             :string           default("comments")
#  created_at       :datetime
#  updated_at       :datetime
#

class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment
  include PublicActivity::Common

  acts_as_readable on: :created_at

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  default_scope -> { order('created_at ASC') }

  validates :comment, :user_id, :commentable_id, :commentable_type,
    presence: true
  validates :title, length: {maximum: 255}

end
