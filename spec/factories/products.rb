FactoryBot.define do
  factory :product do
    id                         { '2' }
    name                       { 'マコ' }
    price                      { '1' }
    text                       { '1' }
    status                     { '1' }
    stage                      { '1' }
    delivery_responsivility    { '1' }
    delivery_way               { '1' }
    delivery_area              { '1' }
    delivery_day               { '1' }
    created_at                 { '00000000' }
    updated_at                 { '00000000' }
    user_id                    { '2' }
    category_id                { '2' }
    brand_id                   { '2' }

  end
end