module ApplicationHelper


	def awesome_print_html(object)
		(ap object , {:html => true , :color => { :array  => :black } } ).gsub(/style="/ , 'style="background-color:transparent;').html_safe
	end


	def avatar_url(user)
		# if user.avatar_url.present?
		#     user.avatar_url
		# else
	    # default_url = "#{root_url}images/guest.png"
	    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
	    # "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
		# end

		#Some available options for default but user specific identifications

		#https://en.gravatar.com/site/implement/images/
		#identicon
		#retro
		#mosterid
		#wavatar
		if not user.omniauth_image_url.nil?
			"http://gravatar.com/avatar/#{gravatar_id}.png?d=#{user.omniauth_image_url}"
		else
			"http://gravatar.com/avatar/#{gravatar_id}.png?d=identicon"
		end

	end


	def bootstrap_class_for flash_type
	    case flash_type
	      when :success
	        "alert-success"
	      when :error
	        "alert-warning"
	      when :alert
	        "alert-danger"
	      when :danger
	        "alert-danger"	        
	      when :notice
	        "alert-info"
	      else
	        flash_type.to_s
	    end
	end

end
