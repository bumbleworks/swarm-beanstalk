module ProcessHelpers
  def hive
    @hive ||= Swarm::Hive.default
  end
end
