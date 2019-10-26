module ApplicationHelper
  def current_user_id_has?(instance)
    user_signed_in? && current_user.id == instance.id
  end
end
