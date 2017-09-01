class WelcomeController < ApplicationController
  
  def show
    @params = params
  end
  
  def reply
    if params[:commit] == 'Success'
      qry = 'oq=baba'
    else
      qry = "error=#{URI.encode('my error message')}"
    end
    
    params.keys.each do |p|
      unless ['utf8', 'authenticity_token', 'commit', 'controller', 'action'].include?(p.to_s.downcase)
        if ['rstate'].include?(p.to_s.downcase)
          qry = "#{qry}&#{p}=#{params[p]}"
        else
          qry = "#{qry}&#{p}=#{URI.encode(params[p])}"
        end
      end
    end
    
    url =  "#{params['original-url']}/?#{qry}"
    p url
    redirect_to url
  end
  
  def validate
    render nothing: true, status: 200
  end
end