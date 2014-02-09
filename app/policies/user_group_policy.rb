class UserGroupPolicy < Struct.new(:user, :user_group)


	class Scope < Struct.new(:user, :scope)
    def resolve
      scope.where(organisation_id: user.organisation_id)
    end
  end


end