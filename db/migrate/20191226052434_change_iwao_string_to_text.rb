class ChangeIwaoStringToText < ActiveRecord::Migration[6.0]
  def change
    change_column :iwao_configs, :content, :text
  end
end
