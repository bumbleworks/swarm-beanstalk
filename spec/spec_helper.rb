require "simplecov"
SimpleCov.start

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

require "swarm"
require "swarm/beanstalk"

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.expose_dsl_globally = false
  config.include PathHelpers
  config.include ProcessHelpers

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.before(:suite) do
    Swarm::Hive.default = Swarm::Hive.new(
      :storage => Swarm::Storage::HashStorage.new({}),
      :work_queue => Swarm::Beanstalk::Queue.new(:name => "swarm-test-queue")
    )
  end

  config.around(:each, :process => true) do |example|
    hive.work_queue.clear
    worker = Swarm::Engine::Worker.new
    @worker_thread = Thread.new {
      worker.run!
    }
    example.run
    hive.work_queue.add_job({:action => "stop_worker"})
    @worker_thread.join
  end
end
