class AddSymbolToAgreementCategory < ActiveRecord::Migration
  def change
    add_column :agreement_categories, :symbol, :string
  end
end
