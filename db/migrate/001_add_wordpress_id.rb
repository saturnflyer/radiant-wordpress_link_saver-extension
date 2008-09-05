class AddWordpressId < ActiveRecord::Migration

  def self.up
    add_column :pages, :wordpress_id, :integer
  end


  def self.down
    remove_column :pages, :wordpress_id
  end

end
