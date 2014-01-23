class FeedbackPolicy < Struct.new(:user, :feedback)

  def new?
    true
  end

  def create?
    true
  end

  def destroy?
    user.user_group.is_admin and user.organisation.feedbacks.include? feedback
  end

  def show?
    user.user_group.is_admin and user.organisation.feedbacks.include? feedback
  end



  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.where(organisation_id: user.organisation_id)
    end
  end

end