# == Schema Information
#
# Table name: agreement_categories
#
#  id           :integer          not null, primary key
#  title        :string
#  pro_title    :string
#  client_title :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  symbol       :string
#

class AgreementCategory < ActiveRecord::Base

  has_many :user_agreements, foreign_key: :category_id

  validates :symbol, :title, :pro_title, :client_title, presence: true
  validates :symbol, uniqueness: true
  validates :title, :pro_title, :symbol, length: {maximum: 255}

end
