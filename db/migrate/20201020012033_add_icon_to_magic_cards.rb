class AddIconToMagicCards < ActiveRecord::Migration[6.0]
  def change
    add_column :magic_cards, :icon, :string
  end
end
