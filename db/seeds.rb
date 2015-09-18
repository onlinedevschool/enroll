if Rails.env.development?
  Author.create name: "Jim OKelly", email: "jim@onlinedevschool.com",
                password: "jim@onlinedevschool.com",
                password_confirmation: "jim@onlinedevschool.com"
end
