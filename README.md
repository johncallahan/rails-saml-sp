A simple SAML rails client.  You must have a postgres database engine
available (spec'd in config/database.yml).  Clone this repo first,
then run:

~~~~
% rake db:create
% rake db:migrate
% export ASSET_HOST=http://localhost:3000
% export APP_NAME=<SAML entity id name>
% export IDP_CERT="$(cat idp.crt)"
% rails s
~~~~

To deploy on heroku, try:

~~~~
% heroku create
~~~~

Then, using the name it provides (for example, little-goat-12345 but
yours will be different):

~~~~
% heroku config:set HEROKU_APP_NAME=little-goat-12345
% heroku config:set APP_NAME=<SAML entity id name>
% heroku config:set IDP_CERT="$(cat idp.crt)"
% git push heroku master
% heroku run rake db:migrate
~~~~

Then, visit https://little-goat-12345.herokuapp.com/

If you want to create additional sites:

~~~~
% heroku create --remote other
% heroku config:set HEROKU_APP_NAME=big-sheep-98765 --remote other
% heroku config:set APP_NAME=<SAML entity id name> --remote other
% heroku config:set IDP_CERT="$(cat idp.crt)" --remote other
% git push other master
% heroku run rake db:migrate --remote other
~~~~

Then, visit https:://big-sheep-98765.herokuapp.com/
