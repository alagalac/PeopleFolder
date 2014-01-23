class CommentPolicy < Struct.new(:user, :comment)


  def create?
    # ensure that the user has access to the entity
    comment.entity.organisation == user.organisation

  end

  def destroy?
    if user.user_group.is_admin and user.organisation.comments.include? comment
      true
    elsif user.comments.include? comment
      true
    else
      false
    end
  end

  def show?
    user.organisation.comments.include? comment
  end



  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.where(organisation_id: user.organisation_id)
    end
  end

end