class PagesController < ApplicationController
    def homepage
        render plain: "THIS IS TEXT COMING FROM A RAILS APP"
    end
end