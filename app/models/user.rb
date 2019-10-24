class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :products, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_products, through: :likes, source: :product
  has_one :address, dependent: :destroy
  has_one :credit, dependent: :destroy
  has_many :sns_credentials, dependent: :destroy

  accepts_nested_attributes_for :address

  with_options presence: true do
       validates :last_name, on: :validates_step3
       validates :first_name, on: :validates_step3
       validates :last_name_kana, on: :validates_step3
       validates :first_name_kana, on: :validates_step3
       validates :phone_number, on: :validates_step4
       validates :nickname, on: :validates_step3
       validates :password_confirmation, on: :validates_step3
       validates :birthdate_year, on: :validates_step3
       validates :birthdate_month, on: :validates_step3
       validates :birthdate_day, on: :validates_step3
  end

  validates :last_name_kana, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。' }, on: :validates_step3
  validates :first_name_kana, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。' }, on: :validates_step3
  validates :phone_number, format: { with: /\A\d{11}\z/ }, on: :validates_step4

  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = User.where(id: snscredential.user_id).first
    else
      user = User.where(email: auth.info.email).first
      if user.present?
        SnsCredential.create(
          uid: uid,
          provider: provider,
          user_id: user.id
          )
      else
        user = User.new(
          nickname: auth.info.name,
          email:    auth.info.email,
          password: Devise.friendly_token[0, 20],
          phone_number: "08000000000"
          )
      end
    end
    return user
  end

  def self.sns(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    unless snscredential.present?
      snscredential = {
        uid: auth.uid,
        provider: auth.provider
      }
    end
    return snscredential
  end

  def self.set_year
      years = []
      for year in 1900..2019 do
          years << year 
      end
      new_years = years.reverse
      @year = new_years
  end  

  def self.set_month
    months = []
    for month in 1..12 do
        months << month
    end
    @month = months
  end

  def self.set_day
    days = []
    for day in 1..31 do
        days << day
    end
    @day = days
  end  

  
  enum prefecture: {
       "北海道": "北海道",
       "青森県": "青森県",
       "岩手県": "岩手県",
       "宮城県": "宮城県",
       "秋田県": "秋田県",
       "山形県": "山形県",
       "福島県": "福島県",
       "茨城県": "茨城県",
       "栃木県": "栃木県",
       "群馬県": "群馬県",
       "埼玉県": "埼玉県",
       "千葉県": "千葉県",
       "東京都": "東京都",
       "神奈川県": "神奈川県",
       "新潟県": "新潟県",
       "富山県": "富山県",
       "石川県": "石川県",
       "福井県": "福井県",
       "山梨県": "山梨県",
       "長野県": "長野県",
       "岐阜県": "岐阜県",
       "静岡県": "静岡県",
       "愛知県": "愛知県",
       "三重県": "三重県",
       "滋賀県": "滋賀県",
       "京都府": "京都府",
       "大阪府": "大阪府",
       "兵庫県": "兵庫県",
       "奈良県": "奈良県",
       "和歌山県": "和歌山県",
       "鳥取県": "鳥取県",
       "島根県": "島根県",
       "岡山県": "岡山県",
       "広島県": "広島県",
       "山口県": "山口県",
       "徳島県": "徳島県",
       "香川県": "香川県",
       "愛媛県": "愛媛県",
       "高知県": "高知県",
       "福岡県": "福岡県",
       "佐賀県": "佐賀県",
       "長崎県": "長崎県",
       }
end
