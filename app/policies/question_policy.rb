class QuestionPolicy < Struct.new(:user, :question)

  def new?
    true
  end

  def create?
    true
  end

  def destroy?
    if user.user_group.is_admin and user.organisation.questions.include? question
      true
    elsif user.questions.include? question
      true
    else
      false
    end
  end

  def show?
    user.organisation.questions.include? question
  end

  def edit?
    if user.user_group.is_admin and user.organisation.questions.include? question
      true
    elsif user.questions.include? question
      true
    else
      false
    end
  end

  def update?
    edit?
  end

  def vote?
    user.organisation.questions.include? question
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.where(organisation_id: user.organisation_id)
    end
  end

end
