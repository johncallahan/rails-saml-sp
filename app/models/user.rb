class User < ApplicationRecord
  devise :saml_authenticatable, :trackable
end
