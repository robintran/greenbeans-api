module Exceptions
  class ApiException < StandardError
    attr :major_code, :diagnostic1, :diagnostic2

    def initialize(params = {})
      @@major_code = params[:major_code] || raise("You must specify a major code when raising an API exception")
      @@diagnostic1 = params[:sub1]
      @@diagnostic2 = params[:sub2]
    end

    def code
      @@major_code
    end
    def major_code
      @@major_code
    end
    def diagnostic1
      @@diagnostic1
    end
    def diagnostic2
      @@diagnostic2
    end
  end
end
