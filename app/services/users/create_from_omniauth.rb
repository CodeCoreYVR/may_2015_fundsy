class Users::CreateFromOmniauth
  include Virtus.model

  attribute :omniauth_data

  attribute :user

  def call
    name = omniauth_data.info.name.split
    @user = User.create!( provider:   omniauth_data.provider,
                         uid:        omniauth_data.uid,
                         address:    omniauth_data.info.location,
                         password:   SecureRandom.hex,
                         first_name: name[0],
                         last_name:  name[1],
                         credentials_token: omniauth_data.credentials.token,
                         credentials_secret: omniauth_data.credentials.secret )

  end

end
