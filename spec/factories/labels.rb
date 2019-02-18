FactoryBot.define do

  factory :label do
    name { "おつかい" }
  end

  factory :second_label, class: Label do
    name { "おるすばん" }
  end

  factory :third_label, class: Label do
    name { "おてつだい" }
  end

end
