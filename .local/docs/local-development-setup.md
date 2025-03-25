# Local Development Setup

## Requirements

You'll need to have the following installed on your local machine:

- [Docker](https://docs.docker.com/get-docker/)
- [VIP CLI](https://docs.wpvip.com/technical-references/vip-cli/) version >= 2.37.0
- [Node.js](https://nodejs.org/en/) version > 20
- [npm CLI](https://docs.npmjs.com/cli/v8) version > 10
- [PHP](https://www.php.net/) version = 8.2.x
- [Composer](https://getcomposer.org/)

## Setup

- `npm run env:init`: This command will set up the [VIP local environment](https://docs.wpvip.com/technical-references/vip-local-development-environment/) and install Composer and Node.js dependencies.
During this command, you will be prompted multiple questions.
  - WordPress site title: the name of the site
  - Multisite: depends on the requirements of the project
  - PHP version to use: 8.2
  - WordPress - Which version would you like: 6.4
  - How would you like to source vip-go-mu-plugins: Demo - Automatically fetched vip-go-mu-plugins
  - How would you like to source application code: Custom - Path to a locally cloned application code directory --> enter "./"
  - Enable Elasticsearch (needed by Enterprise Search)? (Y/n): depends on the requirements of the project
  - Enable phpMyAdmin (Y/n): can be useful for local development
  - Enable XDebug (Y/n): can be useful for local development
  - Enable Mailpit (Y/n): can be useful for local development
  - Enable Photon (Y/n): Enable Photon (Y/n) › false

Once completed ignore the advice to run the `vip dev-env start --slug rv-starter` command (replace `rv-starter` with actual slug).

- `npm run build`: This command will build the assets for the theme and plugins.
- `npm run env:start`: This command will start the VIP local environment and will indicate the available local URLs for the RV Starter site as well as the login credentials (default username: `vipgo` and password: `password`). Note that for the site URLS to work, you might have to edit your host file.
- `npm run env:db:import ./.local/db_dumps/{db-name}.sql`: This installs the DB from the db_dumps folder.
- `npm run env:wp cache flush`: This flushes the cache.

In order to stop the local environment you can run the following command:

- `npm run env:stop`

If you need to import a remote database dump you can first place the database SQL dump file in the `./.local/db_dumps/` directory. Once done you'll need to run the following commands (replacing the placeholders by the relevant data):

- `npm run env:db:search-replace -- ./.local/db_dumps/NAME_OF_THE_DB_DUMP_FILE.sql -s="THE_REMOTE_SITE_DOMAIN_NAME,YOUR_LOCAL_SITE_DOMAIN_NAME" -o="./.local/db_dumps/import.sql"`: This will search and replace inside the database dump the domain name from the remote site with the domain name from your local site.
- `npm run env:db:import ./.local/db_dumps/import.sql`: This will import the modified database dump into the local database.
- `npm run env:wp cache flush`: Flush the cache in order to allow creation of user.
- `npm run env:wp user create vipgo vipgo@local.com -- --user_pass=password`: Re-create the `vipgo` user.
- `npm run env:wp -- super-admin add vipgo`: Set the `vipgo` user as a super admin.
- `npm run env:wp cache flush`: Flush the cache.


There are also the following additional commands that you might find useful:

- `npm run env:exec ARGS`: This command will allow you to run an arbitrary commands on the container running the WordPress environment.
- `npm run env:wp ARGS`: This command will allow you to run WP CLI commands on the container running the WordPress environment.
- `npm run env:logs ARGS`: This command will allow you to tail the logs of all the local environment containers.
- `npm run env:info`: This command will allow you to get some information about the VIP local environment.
- `npm run env:destroy`: This command will allow you to completely destroy the VIP local environment.

Finally, this setup will create a symlink into the `./.local/site` directory to the VIP local environment.
In this directory you'll be able to find and edit the site `wp-config.php` file (in `./.local/site/config`. Also, you'll find some log (`log/debug.log`) and the site `uploads` directory.
