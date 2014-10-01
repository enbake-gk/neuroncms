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

		if no param find.all
		else
			[find.where]

		end

		for each record
			for key value
				if key is an array
					asso = ce.where(slug in [value])
					arr[key] = asso
				end
			end
		end

		if no param return arr
		else retnr arr[0]		



		@ruby_result = JSON.parse(@result)
       
        @info = Locomotive::ContentEntry.where(:_slue => "book").first
        abort @info

        tag_detail_list = []
        @get_tags = @ruby_result.map{|x| x["tags"]}
        @get_tags.each do |get_tag|
      	
       	get_tag.each do |tag_detail|

       	# get_tag_details = Locomotive::ContentEntry.where({ text: /^.*#{tag_detail}.*$/i } )

       	# abort get_tag_details.to_json
       		# if count = 2
       		# puts tag_detail
       		# tag_detail_list << tag_detail
       		# abort tag_detail_list
       		# end
       		# count = count + 1
       	end
       end

	end


end

