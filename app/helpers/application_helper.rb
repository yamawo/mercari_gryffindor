module ApplicationHelper
  def current_user_id_has?(instance)
    user_signed_in? && current_user.id == instance.id
  end

  def sold_out?(instance)
    instance.status == 0
  end
end
