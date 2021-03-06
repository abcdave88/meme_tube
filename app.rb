require 'pry-byebug'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'


get '/' do
  redirect to('/index')
end

get '/new' do
  erb :new
end

post '/index' do
  sql = "insert into videos (title, description, url, genre) values ('#{params['title']}', '#{params['description']}', '#{params['url']}', '#{params['genre']}')"
  run_sql(sql)
  redirect to('/')
end

get '/index' do
  sql =  "select * from videos"
  @videos = run_sql(sql)
  erb :index
end


def run_sql(sql)
  conn = PG.connect(dbname: 'memetube', host: 'localhost')
  begin
    result = conn.exec(sql)
  ensure
    conn.close
  end
  result
end