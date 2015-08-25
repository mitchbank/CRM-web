require_relative 'contact'
require 'sinatra'

get '/' do
	@crm_app_name = "My CRM"
	erb :index
end

get '/contacts' do
	@contacts = []
	@contacts << Contact.new("Yehuda", "Katz", "yehuda@example.com", "Developer")
	@contacts << Contact.new("Mark", "Zuckerberg", "Mark@facebook.com", "CEO")
	@contacts << Contact.new("Sergei", "Brin", "Sergei@google.com", "Used to be CEO")

	erb :contacts
end

get '/contacts/new' do
	"Create and new contact"
end