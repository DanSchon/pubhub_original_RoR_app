Fabricator(:review) do
  body { Faker::Lorem.paragraph(3) }
end