class AddLinkToResults < ActiveRecord::Migration
  def change
    add_column :results, :link, :string
  end
end
