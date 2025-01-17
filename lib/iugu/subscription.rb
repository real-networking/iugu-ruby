module Iugu
  class Subscription < APIResource
    include Iugu::APIFetch
    include Iugu::APICreate
    include Iugu::APISave
    include Iugu::APIDelete

    def add_credits(quantity)
      copy Iugu::Factory.create_from_response(self.class.object_type,
                                              APIRequest.request('PUT',
                                                                 "#{self.class.url(self.id)}/add_credits",
                                                                 { quantity: quantity }))
      self.errors = nil
      true
    rescue Iugu::RequestWithErrors => ex
      self.errors = ex.errors
      false
    end

    def remove_credits(quantity)
      copy Iugu::Factory.create_from_response(self.class.object_type,
                                              APIRequest.request('PUT',
                                                                 "#{self.class.url(self.id)}/remove_credits",
                                                                 { quantity: quantity }))
      self.errors = nil
      true
    rescue Iugu::RequestWithErrors => ex
      self.errors = ex.errors
      false
    end

    def suspend
      copy Iugu::Factory.create_from_response(self.class.object_type,
                                              APIRequest.request('POST',
                                                                 "#{self.class.url(self.id)}/suspend"))
      self.errors = nil
      true
    rescue Iugu::RequestWithErrors => ex
      self.errors = ex.errors
      false
    end

    def activate
      copy Iugu::Factory.create_from_response(self.class.object_type,
                                              APIRequest.request('POST',
                                                                 "#{self.class.url(self.id)}/activate"))
      self.errors = nil
      true
    rescue Iugu::RequestWithErrors => ex
      self.errors = ex.errors
      false
    end

    def change_plan(plan_identifier, options = {})
      options.merge!({ plan_identifier: plan_identifier })
      copy Iugu::Factory.create_from_response(self.class.object_type,
                                              APIRequest.request('POST',
                                                                 "#{self.class.url(self.id)}/change_plan",
                                                                 options))
      self.errors = nil
      true
    rescue Iugu::RequestWithErrors => ex
      self.errors = ex.errors
      false
    end

    def change_plan_simulation(plan_identifier, options = {})
      options.merge!({ plan_identifier: plan_identifier })
      Iugu::Factory.create_from_response(self.class.object_type,
                                         APIRequest.request('GET',
                                                            "#{self.class.url(self.id)}/change_plan_simulation",
                                                            options))
    end

    def change_subitems(subitems, options = {})
      options.merge!({ subitems: subitems })
      Iugu::Factory.create_from_response(self.class.object_type,
                                          APIRequest.request('PUT',
                                                            "#{self.class.url(self.id)}/",
                                                            options))
    end

    def customer
      return false unless @attributes['customer_id']
      Customer.fetch @attributes['customer_id']
    end
  end
end
