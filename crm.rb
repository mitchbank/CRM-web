require_relative 'rolodex'
# require_relative 'contact'
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
	include DataMapper::Resource 

	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :notes, String
end

DataMapper::finalize
DataMapper::auto_upgrade!

$rolodex = Rolodex.new
# $rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny.bravo@hotmail.com", "prrrrretty mama"))

contact = $rolodex.find(1000)

get '/' do
	@crm_app_name = "Mitchbook"
	erb :index
end

get '/contacts' do
	@contacts = Contact.all
	erb :contacts
end

get '/contacts/new' do
	erb :new_contact
end

post '/contacts' do
	# new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:notes])
	# $rolodex.add_contact(new_contact)
	contact = Contact.create(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:notes => params[:notes]
		)
	redirect to('/contacts')
end

get '/contacts/:id' do 
		@contact = Contact.get(params[:id].to_i)
		if @contact
		erb :show_contact
	else
		raise Sinatra::NotFound
	end
end

get '/contacts/:id/edit' do 
	@contact = Contact.get(params[:id].to_i)
	if @contact
		erb :edit_contact
	else
		raise Sinatra::NotFound
	end
end

put '/contacts/:id' do 
		@contact = Contact.get(params[:id].to_i)
		if @contact
		@contact.update(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:notes => params[:notes]
		)

		redirect to('/contacts')
	else
		raise Sinatra::NotFound
	end
end	

delete '/contacts/:id' do 
	@contact = Contact.get(params[:id].to_i)	
	if @contact
		Contact.remove_contact(@contact)
		redirect to('/contacts')
	else
		raise Sinatra::NotFound
	end
end	