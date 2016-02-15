Fabricator(:pub) do 
  title { Faker::Name.title }
  url { Faker::Internet.url }
  content { Faker::Lorem.paragraph }
end