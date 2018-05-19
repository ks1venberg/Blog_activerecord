#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, 'sqlite3:newsblog.db'


class News < ActiveRecord::Base
# comments! - not "comment"
has_many :comments
	# validates :username, presence: true
	# validates :ntext, presence: true, length: {minimum: 3}
end

class Comment < ActiveRecord::Base
belongs_to :news
	# validates :cmname, presence: true
	# validates :cmtext, presence: true, length: {minimum: 3}
end

before do
	#@nnn = News.new
	@newsresult = News.all
end


get '/' do
	# erb "lets start!"
	# @newsresult = @db.execute 'select * from newstable order by id desc'
	erb :index		
end

get '/news' do
	erb :addnews	
end

get '/comments' do
	erb "Comments"
end

get '/contacts' do
	erb "Contacts"
end

get '/news/:news_id' do
	@news_id = params[:news_id]
	detailnew = @db.execute 'select * from newstable where id = ?', [@news_id]
	@resdetail = detailnew[0]
	@news_comment = @db.execute 'select * from comments where news_id = ?', [@news_id]

	erb :detnews
	# erb "Displaying this news with id# #{news_id} in details"
end

post '/news/:news_id' do
	@news_id = params[:news_id]
	@cmtext = params[:comment_text]
	@cmname = params[:commenter_name]

	# erb "#{@cmname}, you`ve typed comment #{@cmtext} to news with id# #{@news_id}"

	if @cmname.length<=0
		@error = "Введите ваше имя"
		# erb :detnews
	end

	if @cmtext.length<=0
		@error = "Введите сообщение"
		# erb :detnews
	end

	if @cmname.length !=0 && @cmtext.length != 0

		@db.execute 'INSERT INTO comments

		(
		news_id,
		cmname,
		cmtext,
		cdatetime
		)

		values 
		(
		?,
		?,
		?,
		datetime()
		 )', [@news_id, @cmname, @cmtext]

		redirect to ('/new/' + @news_id)
	else
		@error
		# erb :detnews	
	end
end


post '/news' do
	@nnn = News.new params[:news]

	if @nnn.save
		erb "Thank you for adding information!"
	else
		@error = @nnn.errors.full_messages
		erb :addnews	
	end
	
end
