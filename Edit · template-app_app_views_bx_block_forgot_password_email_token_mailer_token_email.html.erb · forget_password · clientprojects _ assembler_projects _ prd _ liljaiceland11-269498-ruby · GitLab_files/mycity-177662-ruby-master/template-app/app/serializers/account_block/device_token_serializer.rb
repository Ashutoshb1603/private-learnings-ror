module AccountBlock
	class DeviceTokenSerializer < BuilderBase::BaseSerializer
		attributes :id, :token, :platform
	end
end