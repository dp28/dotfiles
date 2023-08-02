class TicketBranch
  def initialize(dependencies:)
    @dependencies = dependencies
  end

  def name
    @name ||= `git rev-parse --abbrev-ref HEAD`
  end

  private

  def parts
    name.split("/")
  end
end
