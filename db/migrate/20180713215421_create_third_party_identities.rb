class CreateThirdPartyIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :third_party_identities do |t|
      t.references :user, foreign_key: true
      t.string :provider_name
      t.string :provider_side_id
      t.string :status

      t.timestamps
    end
  end
end
