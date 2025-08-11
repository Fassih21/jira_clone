class TicketPolicy < ApplicationPolicy
  def index?
    user.admin? || user.dev? || user.qa? || user.user?
  end

  def show?
    return true if user.admin?

    if user.dev?
      record.assigned_developer_id == user.id
    elsif user.qa?
      record.assigned_qa_id == user.id
    else
      record.creator_id == user.id
    end
  end

  def create?
    user.admin? || user.user?
  end

  def update?
    user.admin? || user.dev?
  end

  def assign?
    user.admin?
  end

  def mark_done?
    user.admin? || user.qa?
  end

  def destroy?
    user.admin?
  end

  class Scope < ApplicationPolicy::Scope
    # def resolve
    #   scope.all
    # end
  end
end
