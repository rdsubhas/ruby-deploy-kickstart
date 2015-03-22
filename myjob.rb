require 'rufus-scheduler'
require 'logger'

logger = Logger.new(STDOUT)
$stdout.sync = true

scheduler = Rufus::Scheduler.new

scheduler.every '10s' do
  logger.info "My job is triggered!"
end

logger.info 'My jobs are running!'
scheduler.join
