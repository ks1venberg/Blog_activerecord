class CreateNewstable < ActiveRecord::Migration[5.2]
  def change
  		create_table :news_tbl do |q|
  			q.text :username
			q.text :ntext
			q.timestamp :datetime
		end

		create_table :comm_tbl do |q|
			q.belongs_to :news_tbl, index: true
			q.text :cmname
			q.text :cmtext
			q.timestamp :cdatetime
		end
  end
end
