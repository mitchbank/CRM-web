require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

$rolodex = Rolodex.new
$rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny.bravo@hotmail.com", "prrrrretty mama"))

contact = $rolodex.find(1000)

get '/' do
	@crm_app_name = "My CRM"
	erb :index
end

get '/contacts' do
	erb :contacts
end

get '/contacts/new' do
	erb :new_contact
end

post '/contacts' do
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:notes])
	$rolodex.add_contact(new_contact)
	redirect to('/contacts')
end

get '/contacts/:id' do 
		if @contact = $rolodex.find(params[:id].to_i)
		erb :show_contact
	else
		raise Sinatra::NotFound
	end
end

get '/contacts/:id/edit' do 
	if @contact = $rolodex.find(params[:id].to_i)
		erb :edit_contact
	else
		raise Sinatra::NotFound
	end
end

put '/contact/:id' do 
		@contact = $rolodex.find(params[:id].to_i)
	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]
		@contact.notes = params[:notes]

		redirect to('/contacts')
	else
		raise Sinatra::NotFound
	end
end	

delete '/contacts/:id' do 
	@contact = $rolodex.find(params[:id].to_i)	
	if @contact
		$rolodex.remove_contact(@contact)
		redirect to('/contacts')
	else
		raise Sinatra::NotFound
	end
end	