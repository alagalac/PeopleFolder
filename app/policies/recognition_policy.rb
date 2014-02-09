class RecognitionPolicy < Struct.new(:user, :recognition)

	def new?
		true
	end

	def create?
		user.organisation.users.include? recognition.recognised
	end

	class Scope < Struct.new(:user, :scope)
    def resolve
      scope.where(organisation_id: user.organisation_id)
    end
  end

end