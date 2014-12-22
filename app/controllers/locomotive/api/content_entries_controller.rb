module Locomotive
  module Api
    class ContentEntriesController < BaseController

      load_and_authorize_resource({
        class:                Locomotive::ContentEntry,
        through:              :get_content_type,
        through_association:  :entries,
        find_by:              :find_by_id_or_permalink
      })

      # before_filter :find_file_in_model, only: [:create, :update]

      def index
        @content_entries = @content_entries.order_by([get_content_type.order_by_definition])
        respond_with @content_entries
      end

      def show
        respond_with @content_entry, status: @content_entry ? :ok : :not_found
      end

      def create
        @content_entry.from_presenter(params[:content_entry] || params[:entry])
        @content_entry.save
        respond_with @content_entry, location: main_app.locomotive_api_content_entries_url(@content_type.slug)
      end

      def update      
        @content_entry.from_presenter(params[:content_entry] || params[:entry])
        @content_entry.save
        respond_with @content_entry, location: main_app.locomotive_api_content_entries_url(@content_type.slug)
      end

      def destroy
        @content_entry.destroy
        respond_with @content_entry, location: main_app.locomotive_api_content_entries_url(@content_type.slug)
      end

      protected
      def find_file_in_model

        ### Find if file type exist in ContentType model ###
        ### Start ###
             @locomotive_model = Locomotive::ContentType.where(slug: params[:slug]).first
            if params[:id].present?
               @entries = Locomotive::ContentEntry.where({ :id => params[:id]})
            else
               @entries = @locomotive_model.entries
            end
           # iterate each entries
           @entries.each do |entries|
                entries["custom_fields_recipe"]["rules"].each do |recipe|
                  recipe.each_pair do |k, v|
                    # Replace params file(Base64) with originl file
                    if(v == "file")       
                            params[:content_entry][recipe["name"]] =  convert_data_uri_to_upload(params[:content_entry][recipe["name"]])  
                    end
                  end
                end
            end
          ### End ###

        @content_entry.from_presenter(params[:content_entry] || params[:entry])
        @content_entry.save
        respond_with @content_entry, location: main_app.locomotive_api_content_entries_url(@content_type.slug)
      end
      
       # Split up a data uri
      def split_base64(uri_str)
        if uri_str.match(%r{^data:(.*?);(.*?),(.*)$})
          uri = Hash.new
          uri[:type] = $1 # "image/gif"
          uri[:encoder] = $2 # "base64"
          uri[:data] = $3 # data string
          uri[:extension] = $1.split('/')[1] # "gif"
          return uri
        else
          return nil
        end
      end

      # Convert data uri to uploaded file. Expects object hash, eg: params[:post]
      def convert_data_uri_to_upload(obj_hash)
        if obj_hash.try(:match, %r{^data:(.*?);(.*?),(.*)$})
          image_data = split_base64(obj_hash)
          image_data_string = image_data[:data]
          image_data_binary = Base64.decode64(image_data_string)
          temp_img_file = Tempfile.new("data_uri-upload")
          temp_img_file.binmode
          temp_img_file << image_data_binary
          temp_img_file.rewind

          img_params = {:filename => "data-uri-img.#{image_data[:extension]}", :type => image_data[:type], :tempfile => temp_img_file}
          uploaded_file = ActionDispatch::Http::UploadedFile.new(img_params)
        end


        return uploaded_file    
      end


      def get_content_type
        @content_type ||= current_site.content_types.where(slug: params[:slug]).first
      end

    end
  end
end
