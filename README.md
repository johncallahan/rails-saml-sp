A simple SAML rails client.  You must have Ruby-on-Rails 5+, a
postgres database engine available (spec'd in config/database.yml).
See [Shibboleth for Beginners-Part
1](https://medium.com/@johnrcallahan/shibboleth-for-beginners-part-1-f8fb59b87fa2)
for instructions on setting up a JumpCloud SAML (and LDAP) identity
provider (IdP).  Run the following commands to deploy locally
(development):

~~~~
% git clone https://github.com/johncallahan/rails-saml-sp.git
% cd rails-saml-sp
% bundle install
% openssl genrsa -out idp.pem 2048
% openssl req -new -x509 -sha256 -key idp.pem -out idp.crt -days 365
% export ASSET_HOST=http://localhost:3000
% export ENTITY_ID=<SAML entity id name>
% export IDP_SSO_URL=<SAML SSO url>
% export IDP_SLO_URL=<SAML SLO url>
% export IDP_CERT="$(cat idp.crt)"
% rake db:create
% rake db:migrate
% rails s
~~~~

Visit [http://localhost:3000](http://localhost:3000/) in a browser.
To deploy on heroku, try:

~~~~
% heroku create
~~~~

Then, using the name it provides (for example, little-goat-12345 but
yours will be different):

~~~~
% heroku config:set HEROKU_APP_NAME=little-goat-12345
% heroku config:set ENTITY_ID=<SAML entity id name>
% heroku config:set IDP_SSO_URL=<SAML SSO url>
% heroku config:set IDP_SLO_URL=<SAML SLO url>
% heroku config:set IDP_CERT="$(cat idp.crt)"
% git push heroku master
% heroku run rake db:migrate
~~~~

Then, visit https://little-goat-12345.herokuapp.com/

If you want to create additional sites:

~~~~
% heroku create --remote other
% heroku config:set HEROKU_APP_NAME=big-sheep-98765 --remote other
% heroku config:set ENTITY_ID=<SAML entity id name> --remote other
% heroku config:set IDP_SSO_URL=<SAML SSO url> --remote other
% heroku config:set IDP_SLO_URL=<SAML SLO url> --remote other
% heroku config:set IDP_CERT="$(cat idp.crt)" --remote other
% git push other master
% heroku run rake db:migrate --remote other
~~~~

Then, visit https:://big-sheep-98765.herokuapp.com/

With [rails-saml-idp project](https://github.com/johncallahan/rails-saml-idp), 

~~~~
export ASSET_HOST=http://localhost:3000
export ENTITY_ID=
export SP_NAME=http://localhost:3001/saml/auth
export IDP_CERT_FINGERPRINT="<fingerprint value SHA1>"
export IDP_CERT=
export IDP_SSO_URL=http://localhost:3001/saml/auth
export IDP_SLO_URL=http://localhost:3001/saml/auth?slo=true
~~~~
