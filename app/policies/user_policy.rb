class UserPolicy < Struct.new(:user, :user_to_edit)

  def index?
    user.user_group.is_admin
  end

  def new?
    user.user_group.is_admin
  end

  def create?
    user.user_group.is_admin
  end

  def destroy?
    user.user_group.is_admin and user.organisation.users.include? user_to_edit
  end

  def show?
    user.user_group.is_admin and user.organisation.users.include? user_to_edit
  end

  def edit?
    user.user_group.is_admin and user.organisation.users.include? user_to_edit
  end

  def update?
    user.user_group.is_admin and user.organisation.users.include? user_to_edit
  end



  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.where(organisation_id: user.organisation_id)
    end
  end


end