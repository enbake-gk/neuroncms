class SearchController < Locomotive::Api::BaseController

	def search_by_name
		model = params[:model_slug]
		entry_name = params[:entry_name]
		tag_name = params[:tag]
		@Locomotive_Model = Locomotive::ContentType.where( "slug" => model).first  
	    @entries
	    if @Locomotive_Model.present?
	    	if entry_name.present?
	    	  @entries = @Locomotive_Model.entries.where("name" => entry_name)
	      	else
	      	  @entries = @Locomotive_Model.entries.where(:tags.in => [tag_name])
	        end
	    end

	  	respond_to do |format|
	     format.json { render json: @entries  }
	    end
	end

end
