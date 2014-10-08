class SearchController < Locomotive::Api::BaseController

	def search_by_name
		model = params[:model]
		column = params[:column]
		value = params[:value]
		
		unless column.present?
			column = 'name'
		end

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


	def nested  
		begin
			@locomotive_model = Locomotive::ContentType.where({ name: /^.*#{params[:model]}.*$/i } ).first  
		    if @locomotive_model.present?
			    value_arr = []
			    nested_model = {}
			    final_object = []

		    	if params[:id].present?
		    	   @entries = Locomotive::ContentEntry.where({ :id => params[:id]})
		        else
		    	   @entries = @locomotive_model.entries
		        end
		  
			    # iterate each entries
				@entries.each do |entries|
			            # iterate each entries with key and value 
						entries.attributes.each_pair do |key, value|
							# check if array is exists in entry
								if value.is_a?(Array) && key.include?("ids")
									   # itereate array with key and value
					                   value.each_with_index  do |item, index|
					                   	# Find each nested record
						                   value_arr << Locomotive::ContentEntry.where({ :id => item})
					                   end
				                   nested_model.merge!({key.to_s => value_arr})
							   end
					    end	
					    entries.attributes.merge!(nested_model) if nested_model.present?
			            # final_object.merge!(entries.attributes)
			            final_object << entries.attributes
			    end
		  	end 
	    rescue
		    final_object = 'Invalid Request! Please check and try again'
		end
		respond_to do |format|
		       format.json { render json: final_object }
		end
	end

end

