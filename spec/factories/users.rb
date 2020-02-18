
FactoryGirl.define do
  factory :user do

    omniauth_payload = Faker::Omniauth.github #Almost similar to Gitlab

    provider { omniauth_payload[:provider] }
    access_token { "s3cr3t@acc3sst0k3n" }
    email { omniauth_payload[:info][:email] }
    handle { "user-handle" }
    picture { omniauth_payload[:info][:image]}
    fullname { omniauth_payload[:info][:name]}
    bio { "Lorem ipsum in culpa eu sint sit amet voluptate veniam ut sed reprehenderit sit veniam ea labore eu voluptate est mollit id ut in labore dolor dolore in enim ut sint duis ad duis."}
    gid { omniauth_payload[:uid]}
  end
end