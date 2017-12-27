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
            @page_number = ''
        else
            @page_number = "?page=#{page_number}"
        end
        
        response = self.class.get("#{@base_uri}/message_threads#{@page_number}", headers: { "authorization" => @auth_token })
        JSON.parse(response.body)
    end
    
end