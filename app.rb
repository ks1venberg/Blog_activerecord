#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, 'sqlite3:newsblog.db'


class News < ActiveRecord::Base
# comments! - not "comment"
has_many :comments
	validates :username, presence: true
	validates :ntext, presence: true, length: {minimum: 3}
end

class Comment < ActiveRecord::Base
belongs_to :news
	validates :cmname, presence: true
	validates :cmtext, presence: true, length: {minimum: 3}
end

get '/' do
	erb "lets start!"
	# @newsresult = @db.execute 'select * from newstable order by id desc'
	# erb :index		
end

get '/news' do
	erb :news	
end

get '/comments' do
	erb "Comments"
end

get '/contacts' do
	erb "Contacts"
end

get '/new/:news_id' do
	@news_id = params[:news_id]
	detailnew = @db.execute 'select * from newstable where id = ?', [@news_id]
	@resdetail = detailnew[0]
	@news_comment = @db.execute 'select * from comments where news_id = ?', [@news_id]

	erb :detnews
	# erb "Displaying this news with id# #{news_id} in details"
end

post '/new/:news_id' do
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
	@username = params[:username]
	@ntext = params[:news_text]

	if @username.length<=0
		@error = "введите ваше имя"
		erb :news
	end

	if @ntext.length<=0
		@error = "введите сообщение"
		erb :news
	end

	if @username.length !=0 && @ntext.length != 0

		@db.execute 'INSERT INTO newstable

		(
		username,
		ntext,
		datetime
		)

		values 
		(
		?,
		?,
		datetime()
		 )', [@username, @ntext]

		 # если не использовать редирект то можно вывести эту строку
		# erb "#{@username}, thanks for addind this news: #{@ntext}"
		redirect to ('/')
	else
		erb :news	
	end
	
end
