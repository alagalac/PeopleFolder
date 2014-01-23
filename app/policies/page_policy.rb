class PagePolicy < Struct.new(:user, :page)

  def new?
    true
  end

  def create?
    true
  end

  def destroy?
    if user.user_group.is_admin and user.organisation.pages.include? page
      true
    elsif user.pages.include? page
      true
    else
      false
    end
  end

  def show?
    user.organisation.pages.include? page
  end

  def edit?
    if user.user_group.is_admin and user.organisation.pages.include? page
      true
    elsif user.pages.include? page
      true
    else
      false
    end

  end

  def update?
    if user.user_group.is_admin and user.organisation.pages.include? page
      true
    elsif user.pages.include? page
      true
    else
      false
    end
  end



  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.where(organisation_id: user.organisation_id)
    end
  end

end