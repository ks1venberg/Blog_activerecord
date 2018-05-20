class CreateRumor < ActiveRecord::Migration[5.2]
  def change
  	  		create_table :rumor_tbl do |q|
  			q.text :username
			q.text :ntext
			q.timestamp
		end
  end
end
