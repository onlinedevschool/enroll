desc 'pull down production data'
namespace :db do
  desc "Restore latest Heroku db backup locally"
  task "fetch:production" => :environment do
    # Get the current db config
    config = Rails.configuration.database_configuration[Rails.env]
    # Get around an issue with the Heroku Toolbelt https://github.com/sstephenson/rbenv/issues/400#issuecomment-18742700
    Bundler.with_clean_env do
       # make backup
       `heroku pg:backups capture -a ods-production`
       # Download the latest backup to a file called latest.dump in tmp folder
      `curl -o tmp/latest.dump \`heroku pg:backups public-url -q --remote production\``
       # Restore the backup to the current database
      `export PGPASSWORD=#{config["password"]} && pg_restore --verbose  --clean  --no-acl --no-owner --host=#{config["host"]} --port=#{config["port"]} --username=#{config["username"]} --dbname=#{config["database"]} tmp/latest.dump`
    end
  end
end
