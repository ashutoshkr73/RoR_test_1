class ApplicationController < ActionController::Base
    include SessionsHelper            #  its a module
    def index
       render html: "Hello-World!"
    end    
end
