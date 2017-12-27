class Kele
    
require 'httparty'

    include HTTParty
    
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
    
    def get_roadmap(roadmap_id)
        response = self.class.get("#{@base_uri}/roadmaps/#{roadmap_id}/", headers: { "authorization" => @auth_token })
        JSON.parse(response.body)
    end
    
    def get_checkpoint(checkpoint_id)
        response = self.class.get("#{@base_uri}/checkpoints/#{checkpoint_id}/", headers: { "authorization" => @auth_token })
        JSON.parse(response.body)
    end
    
end