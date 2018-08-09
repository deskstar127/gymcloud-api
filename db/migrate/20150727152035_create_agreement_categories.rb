class CreateAgreementCategories < ActiveRecord::Migration
  def change
    create_table :agreement_categories do |t|
      t.string :title
      t.string :pro_title
      t.string :client_title

      t.timestamps null: false
    end
  end
end
