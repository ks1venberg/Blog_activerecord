class CreateRemark < ActiveRecord::Migration[5.2]
  def change
  		create_table :remark_tbl do |q|
			q.text :cmname
			q.text :cmtext
			q.timestamp
		end
  end
end
