class CampaignDecorator < Draper::Decorator
  delegate_all

  def title
    # object refers to the object we're decorating which is a Campaign object
    # in this case
    object.title.capitalize
  end

  def edit_button
    if h.can? :edit, object
      h.link_to "edit", h.edit_campaign_path(object)
    end
  end

  def delete_button
    if h.can? :destroy, object
      h.link_to "delete", object, method: :delete, data: {confirm: "Are you sure?"}
    end
  end

  def publish_button
    if h.can? :publish, object
      h.link_to "publish", h.campaign_publishings_path(object), method: :post,
                  data: {confirm: "Are you sure? You won't be able to edit it again"}
    end
  end

  def cancel_button
    if h.can? :cancel, object
      h.link_to "cancel", h.campaign_cancellings_path(object), method: :post,
                        data: {confirm: "Are you sure?"}
    end
  end

  def state_class
    case object.aasm_state
    when "published"
      "label-primary"
    when "draft"
      "label-default"
    when "cancelled"
      "label-warning"
    when "failed"
      "label-danger"
    when "goal_attained"
      "label-success"
    end
  end


  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
