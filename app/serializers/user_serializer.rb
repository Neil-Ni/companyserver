class UserSerializer
  def call(user)
    {
      user_uuid:            user.id.to_s,
      name:                 user.first_name,
      internal_id:          '1',
      company_uuid:         user.company_id.to_s,
      email:                user.email,
      confirmed_and_active: user.confirmed_at?,
      phonenumber:          user.phonenumber,
      photo_url:            'https://avatars1.githubusercontent.com/u/18756030?v=3&s=200'
    }
  end
end
