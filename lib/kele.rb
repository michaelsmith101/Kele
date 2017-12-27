class Kele
    
require 'httparty'

    include HTTParty
    
    def initialize(email, password)
         @base_uri = "https://www.bloc.io/api/v1"        
         response = self.class.post("#{@base_uri}/sessions", body: {"email": email, "password": password})
         @auth_token = response["auth_token"]
    end
    
end