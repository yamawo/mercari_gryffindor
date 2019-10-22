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
    category_id             {"23"}
    user_id                 {"1"}
    
    # trait :product_images do
    #   after(:build) do
    #     product.ptoduct_images = FactoryBot.build_list(:image, 2)
    #   end
    # end
    
  end
  factory :product_with_product_image, class: Product do
    name                      {"a"}
    text                    {"nari"}
    price                   {"1212"}
    status                  {"未使用に近い"}
    delivery_responsivility {"送料込み（出品負担）"}
    delivery_way            {"ゆうメール"}
    delivery_area           {"7"}
    delivery_day            {"2~3日で発送"}
    category_id             {"23"}
    user_id                 {"1"}

    after( :create ) do | product|
      create :product_image, product: product
    end
  end
  
end