require 'faker'

#Create Posts
50.times do
  Post.create!(
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
  )
end

custom_post = { title: "College Football", body: "Is one of the best sports to watch!" }

Post.create(custom_post) unless Post.where(custom_post).first

posts = Post.all

#Create Comments
100.times do
  Comment.create!(
    post: posts.sample,
    body: Faker::Lorem.paragraph
  )
end

custom_comment = { post: posts.sample, body: "UGA is awful" }

Comment.create(custom_comment) unless Comment.where(custom_comment).first

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"