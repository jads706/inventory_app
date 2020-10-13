# Create a main sample admin user.
User.create!(name: "Admin User",
    email: "admin@example.com",
    password: "foobar",
    password_confirmation: "foobar",
    admin: true,
    activated: true,
    activated_at: Time.zone.now)

