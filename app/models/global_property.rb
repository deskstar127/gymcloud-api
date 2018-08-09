# == Schema Information
#
# Table name: global_properties
#
#  id                    :integer          not null, primary key
#  symbol                :string
#  name                  :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  position              :integer
#  property_unit_id      :integer
#  save_property_unit_id :integer
#

class GlobalProperty < ActiveRecord::Base

  has_many :personal_properties, dependent: :destroy
  has_and_belongs_to_many :property_units
  belongs_to :default_unit,
    class_name: PropertyUnit,
    foreign_key: :property_unit_id
  belongs_to :save_unit,
    class_name: PropertyUnit,
    foreign_key: :save_property_unit_id

  validates :name, :symbol, :position, presence: true
  validates :symbol, uniqueness: true
  validates :symbol, :name, length: {maximum: 255}

  default_scope -> { order(position: :asc) }

  before_save :set_default_unit

  private

  def set_default_unit
    return if default_unit
    self.default_unit = property_units.presence&.first
  end

end
