module CreatorHelper
  def respond_to_create(prefix, object_to_create, character)
    respond_to do |format|
      format.html do
        if object_to_create.save
          redirect_to polymorphic_url([@character, object_to_create.class])
        else
          flash.now[:notice] = "Uh oh! Your #{prefix} could not be saved."
          generate_empty_form_objects
          if prefix == 'quality'
            render "/character_qualities/index"
          elsif prefix == 'connection'
            render "/connections/index"
          elsif prefix == 'tool' || prefix == 'weapon'
            render 'inventory/index'
          else
            render "character_#{prefix}s/index"
          end
        end
      end

      format.json do
        if object_to_create.save
          response = {}
          response['character' + prefix] = object_to_create
          method = object_to_create.method(prefix)
          response[prefix] = method.call

          render json: response
        else
          render json: { errors: @character.errors }
        end
      end
    end
  end
end
