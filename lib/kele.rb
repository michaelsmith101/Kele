class Kele
    
require 'httparty'
require './lib/roadmap'

    include HTTParty
    include Roadmap
    
    def initialize(email, password)
         @base_uri = "https://www.bloc.io/api/v1"        
         response = self.class.post("#{@base_uri}/sessions", body: {"email": email, "password": password})
         @auth_token = response["auth_token"]
    end
    
    def get_me
       response = self.class.get("#{@base_uri}/users/me", headers: { "authorization" => @auth_token })
       JSON.parse(response.body)
    end
    
    def get_mentor_availability(mentor_id)
        response = self.class.get("#{@base_uri}/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
        JSON.parse(response.body)
    end
    
    def get_messages(page_number = nil)
        
        if page_number.nil? then 
            page_url = ''
        else
            page_url = "?page=#{page_number}"
        end
        
        response = self.class.get("#{@base_uri}/message_threads#{page_url}", headers: { "authorization" => @auth_token })
        JSON.parse(response.body)
    end
    
    def create_message
       response = self.class.post("#{@base_uri}/messages", 
            body: {
                "sender": "michaelsmith101@gmail.com",
                "recipient_id": 2384373,
                "subject": "Test Subject", 
                "stripped-text": "Test Body"}, 
            headers: { "authorization" => @auth_token }) 
    end

end