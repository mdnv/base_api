json.status "success"

json.data do
  json.(@current_user, :id, :email, :authentication_token)
  json.created_at show_date(@current_user.created_at)
  json.profile do
    json.(@current_user.profile, :id, :gender, :birthday, :phone, :avatar)
  end
end
