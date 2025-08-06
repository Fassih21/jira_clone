class TicketPolicy < ApplicationPolicy
  class TicketPolicy < ApplicationPolicy
  def show?
    user_related?
  end

  def update?
    user_is_creator?
  end

  def destroy?
    user_is_creator?
  end

  def edit?
    update?
  end

  def create?
    true
  end

  def new?
    create?
  end

  def index?
    true
  end

  private

  def user_related?
    record.user_id == user.id || record.dev_id == user.id || record.qa_id == user.id
  end

  def user_is_creator?
    record.user_id == user.id
  end
end


  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
