crumb :root do
  link "メルカリ", root_path
end

crumb :mypage do
  link "マイページ", mypage_users_path
end

crumb :credit do
  link "支払い方法", card_registration_users_path
  parent :mypage
end

crumb :confirmation do
  link "本人情報の登録", confirmation_users_path
  parent :mypage
end

crumb :logout do
  link "ログアウト", logout_users_path
  parent :mypage
end

crumb :profile do
  link "プロフィール", profile_users_path
  parent :mypage
end

crumb :product do |q|
  link "#{q.name_cont}", search_for_path
end