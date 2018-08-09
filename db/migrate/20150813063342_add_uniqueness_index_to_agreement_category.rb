class AddUniquenessIndexToAgreementCategory < ActiveRecord::Migration
  def change
    add_index :agreement_categories, :symbol, unique: true
  end
end
