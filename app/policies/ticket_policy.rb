class TicketPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? ||
      record.creator_id == user.id ||
      record.dev_id == user.id ||
      record.qa_id == user.id
  end

  def create?
    true
  end

  def update?
    user.admin? ||
      record.creator_id == user.id ||
      record.dev_id == user.id ||
      record.qa_id == user.id
  end

  def destroy?
    user.admin? || record.creator_id == user.id
  end

  def mark_done?
    user.admin? || record.dev_id == user.id || record.qa_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.role == "dev"
        scope.where("dev_id = ? OR creator_id = ?", user.id, user.id)
      elsif user.role == "qa"
        scope.where("qa_id = ? OR creator_id = ?", user.id, user.id)
      else
        scope.where(creator_id: user.id)
      end
    end
  end
end
