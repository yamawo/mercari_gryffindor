FactoryBot.define do
   
  factory :product do
    name                      {"a"}
    text                    {"nari"}
    price                   {"1212"}
    status                  {"未使用に近い"}
    delivery_responsivility {"送料込み（出品負担）"}
    delivery_way            {"ゆうメール"}
    delivery_area           {"7"}
    delivery_day            {"2~3日で発送"}
    category_id             {"1"}
    user_id                 {"1"}
  end

  factory :product_with_images, class: Product  do
    name                      {"a"}
    text                    {"nari"}
    price                   {"1212"}
    status                  {"未使用に近い"}
    delivery_responsivility {"送料込み（出品負担）"}
    delivery_way            {"ゆうメール"}
    delivery_area           {"7"}
    delivery_day            {"2~3日で発送"}
    category_id             {"4"}
    user_id                 {"91"}
    size_id                 {"4"}
    brand_id                {"4"}
    trait :image do
      transient do
        iamge {File.open("#{Rails.root}/public/images/a15451168d02bf14fd28c9110b161f8d.jpg")}
      end
    end

    # after (:create) do
    #   create :product_image, 
    # end
  end

  
end






    # product_images_attributes  {:image}
    # trait :product_images do
    #   after(:build) do
    #     product.ptoduct_images = FactoryBot.build_list(:image, 2)
    #   end
    # end
    # factory :product_with_product_image, class: Product do
    #   name                      {"a"}
    #   text                    {"nari"}
    #   price                   {"1212"}
    #   status                  {"未使用に近い"}
    #   delivery_responsivility {"送料込み（出品負担）"}
    #   delivery_way            {"ゆうメール"}
    #   delivery_area           {"7"}
    #   delivery_day            {"2~3日で発送"}
    #   association :product_image, factory: :product_image
    #   after( :create ) do |product|
    #     create :product_image, product: product
    #   end
    # end

    
    
