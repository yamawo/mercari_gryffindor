RSec.feature "Patches", type: :feature do
  scenario "patch test" do
    product = FactoryBot.create( :product_with_product_images )
    expect( Product.count ).to eq 1
    expect( Product_image.count ).to eq 1
  end
end