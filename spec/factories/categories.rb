# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category, :class => 'Categorie' do
    title "MyString"
    description "MyText"
  end
end
