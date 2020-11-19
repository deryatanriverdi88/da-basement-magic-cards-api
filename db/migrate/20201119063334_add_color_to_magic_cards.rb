class AddColorToMagicCards < ActiveRecord::Migration[6.0]
  def change
    add_column :magic_cards, :color, :string
  end
end
