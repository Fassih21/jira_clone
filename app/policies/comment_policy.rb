class CommentPolicy < ApplicationPolicy
    def index?
        record.ticket.creator_id == user.id || record.ticket.dev_id == user.id || record.ticket.qa_id == user.id || user.admin?
    end
    def create?
        record.ticket.creator_id == user.id || record.ticket.dev_id == user.id || record.ticket.qa_id == user.id || user.admin?
    end
    def destroy?
        record.ticket.creator_id == user.id || record.ticket.dev_id == user.id || record.ticket.qa_id == user.id || user.admin?
    end
    class Scope < ApplicationPolicy::Scope
        def resolve
            if user.admin?
                scope.all
            elsif user.role == "dev"
                scope.joins(:ticket).where("tickets.dev_id = ? OR tickets.creator_id = ?", user.id, user.id)
            elsif user.role == "qa"
                scope.joins(:ticket).where("tickets.qa_id = ? OR tickets.creator_id = ?", user.id, user.id)
            else
                scope.joins(:ticket).where("tickets.creator_id = ?", user.id)
            end
        end
    end
end