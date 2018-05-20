class CreateRemrum < ActiveRecord::Migration[5.2]
  def change
  			create_table :rumor_tbl do |q|
  			q.text :username
			q.text :ntext
			q.datetime :created_at
			end

  	  		create_table :remark_tbl do |q|
			q.references :rumor
			q.text :cmname
			q.text :cmtext
			q.datetime :created_at
			end
	end


end
