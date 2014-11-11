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
			# Find model name in contentty
			@locomotive_model = Locomotive::ContentType.where({ slug: /^.*#{params[:model]}.*$/i } ).first  
		    if @locomotive_model.present?
			    final_object = []

		    	if params[:id].present?
		    	   @entries = Locomotive::ContentEntry.where({ :id => params[:id]})
		        else
		    	   @entries = @locomotive_model.entries
		        end
			    # iterate each entries
				@entries.each do |entries|
                        entries["custom_fields_recipe"]["rules"].each do |recipe|
                          recipe.each_pair do |k, v|
                          	# Replace file(image) name  with file_url(location)
                            if(v == "file")
                            	entries.attributes.merge!(recipe["name"]+"_url" => entries.send(recipe["name"]).to_s) 
                                entries.attributes.delete(recipe["name"])
                            end
                             # End Replace file(image) name  with file_url(location)
                               
                             # Find if any assosiation is defined in custom_fiels_recipe 
                             if((v == "belongs_to") || (v == "many_to_many") || (v == "has_many") || (v == "has_one"))
                            	# append object in clas name
                            	entries.attributes.merge!(recipe["name"] => entries.send(recipe["name"]))
                             end
                             # End Finding if assosiation is defined in custom_fiels_recipe 
                          end
                        end
					    entries.attributes.delete("custom_fields_recipe")
			            final_object << entries.attributes
			    end
		  	end 
	    rescue
		    final_object = 'Invalid Request! Please check and try again'
		end

		final_object = 'No record found for model  '+params[:model]  unless @locomotive_model.present?

		respond_to do |format|
		       format.json { render json: final_object }
		end
	end

end

