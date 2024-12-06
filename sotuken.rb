require 'sinatra'
require 'active_record'
require 'sinatra/reloader'
require 'date'
require 'net/http'
require 'uri'
require 'json'

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(:development)

class Post < ActiveRecord::Base
    self.table_name = 'posts'
end

get '/' do
    erb :start
end

get '/new' do
    erb :index
end


get '/life' do
    erb :life
end

get '/work' do
    erb :work
end

get '/money' do
    erb :money
end

get '/dream' do
    erb :dream
end

get '/yourself' do
    erb :yourself
end


post '/life_save' do
    s1 = Post.new
    s1.date = DateTime.now
    s1.title = '人生'
    s1.question1 = params[:question1]
    s1.question2 = params[:question2]
    s1.question3 = params[:question3]
    s1.question4 = params[:question4]
    s1.question5 = params[:question5]
    s1.save
    redirect '/'
end

post '/work_save' do
    s2 = Post.new
    s2.date = DateTime.now
    s2.title = '仕事'
    s2.question1 = params[:question1]
    s2.question2 = params[:question2]
    s2.question3 = params[:question3]
    s2.question4 = params[:question4]
    s2.question5 = params[:question5]
    s2.save
    redirect '/'
end

post '/money_save' do
    s3 = Post.new
    s3.date = DateTime.now
    s3.title = 'お金'
    s3.question1 = params[:question1]
    s3.question2 = params[:question2]
    s3.question3 = params[:question3]
    s3.question4 = params[:question4]
    s3.question5 = params[:question5]
    s3.save
    redirect '/'
end

post '/dream_save' do
    s4 = Post.new
    s4.date = DateTime.now
    s4.title = '夢'
    s4.question1 = params[:question1]
    s4.question2 = params[:question2]
    s4.question3 = params[:question3]
    s4.question4 = params[:question4]
    s4.question5 = params[:question5]
    s4.save
    redirect '/'
end

post '/yourself_save' do
    s5 = Post.new
    s5.date = DateTime.now
    s5.title = '自分'
    s5.question1 = params[:question1]
    s5.question2 = params[:question2]
    s5.question3 = params[:question3]
    s5.question4 = params[:question4]
    s5.question5 = params[:question5]
    s5.save
    redirect '/'
end


post '/process' do
    # ユーザーからのテキストを受け取る
    input_text = params[:question1]
  
    # Pythonサーバーにリクエストを送信
    uri = URI.parse("http://localhost:5001/analyze")  # PythonサーバーのURL
    response = Net::HTTP.post_form(uri, "question1" => input_text)
  
    # Pythonからのレスポンスを処理
    processed_data = JSON.parse(response.body)
  
    # 結果を表示
    "Processed data: #{processed_data['tokens'].join(', ')}"
end


get '/check' do
    @posts = Post.all
    erb :check
end

get '/show/:id' do
    @post = Post.find(params[:id])
    erb :show
end

get '/destroy/:id' do
    Post.find(params[:id]).destroy
    redirect '/check'
end

get '/end' do
    exit
end

