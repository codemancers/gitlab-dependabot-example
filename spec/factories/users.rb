
FactoryGirl.define do
  factory :user do

    omniauth_payload = Faker::Omniauth.github

    provider { omniauth_payload[:provider] }
    email { omniauth_payload[:info][:email] }
    handle { omniauth_payload[:info][:nickname] }
    picture { omniauth_payload[:info][:image]}
    fullname { omniauth_payload[:info][:name]}
    bio { "Lorem ipsum in culpa eu sint sit amet voluptate veniam ut sed reprehenderit sit veniam ea labore eu voluptate est mollit id ut in labore dolor dolore in enim ut sint duis ad duis."}
    gid { omniauth_payload[:uid]}
  end
end