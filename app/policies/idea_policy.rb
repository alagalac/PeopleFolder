class IdeaPolicy < Struct.new(:user, :idea)

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    if user.user_group.is_admin and user.organisation.ideas.include? idea
      true
    elsif user.ideas.include? idea
      true
    else
      false
    end
  end

  def destroy?
    if user.user_group.is_admin and user.organisation.ideas.include? idea
      true
    elsif user.ideas.include? idea
      true
    else
      false
    end
  end

  def show?
    user.organisation.ideas.include? idea

  end

  def update?
    edit?
  end

  def vote?
    user.organisation.ideas.include? idea
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.where(organisation_id: user.organisation_id)
    end
  end

end