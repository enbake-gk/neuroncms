class SearchController < Locomotive::Api::BaseController

	def search_by_name
		model = params[:model]
		column = params[:column]
		value = params[:value]
		begin
		@Locomotive_Model = Locomotive::ContentType.where({ name: /^.*#{model}.*$/i } ).first  
		    if @Locomotive_Model.present?
		    	@entries = @Locomotive_Model.entries.where({"#{column.downcase}" => /^.*#{value}.*$/i})
		    end
		rescue
		    puts 'Invalid Request! Please check and try again'
		end
	  	
	  	respond_to do |format|
	     format.json { render json: @entries  }
	    end
	end


end
