class TicketPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    return true if user.admin?
    return record.dev_id == user.id if user.dev?
    return record.qa_id == user.id if user.qa?
    record.creator_id == user.id
  end

  def create?
    user.present? # any signed-in user can create
  end

  def update?
    user.admin? || (user.dev? && record.dev_id == user.id)
  end

  def assign?
    user.admin?
  end

  def mark_done?
    user.admin? ||
      (user.dev? && record.dev_id == user.id) ||
      (user.qa? && record.qa_id == user.id)
  end

  def destroy?
    user.admin? || (user.user? && record.creator_id == user.id)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      case user.role
      when "admin"
        scope.all
      when "dev"
        scope.where(dev_id: user.id)
      when "qa"
        scope.where(qa_id: user.id)
      when "user"
        scope.where(creator_id: user.id)
      else
        scope.none # return empty relation if role is unknown
      end
    end
  end
end
