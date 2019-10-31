class CreateIwaoConfigs < ActiveRecord::Migration[6.0]
  def change
    create_table :iwao_configs do |t|
      t.string :name
      t.string :content

      t.timestamps
    end
  end
end
