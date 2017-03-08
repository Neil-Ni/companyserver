class WhoamiSerializer
  def call(user)
    {
      support:                 false,
      user_uuid:               user.id
    }
  end
end
