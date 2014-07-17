module DestroyerHelper
  def is_inventory_item(prefix)
    if prefix == 'tool' || prefix == 'weapon'
      true
    else
      false
    end
  end

  def respond_to_destroy(prefix, object_to_destroy_id, character)
    render_unauthorized unless character.user == current_user

    if prefix == 'quality'
      method_to_call = "character_qualities"
    elsif prefix == 'connection'
      method_to_call = prefix + 's'
    else
      method_to_call = "character_" + prefix + 's'
    end

    method = character.method(method_to_call)

    object_to_destroy = method.call.destroy(object_to_destroy_id)

      respond_to do |format|
        format.html do
          flash[:notice] = prefix + ' deleted!'
          if is_inventory_item(prefix)
            redirect_to character_inventory_index_path(@character)
          else
            redirect_to polymorphic_url([@character, object_to_destroy.class])
          end
        end
        format.json do
          render json: object_to_destroy
        end
      end
  end
end
