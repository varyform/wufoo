module Wufoo
  class Query
    attr_accessor :client, :form, :params

    def initialize(client, form, params={})
      @client = client
      @form = form
      @params = {}.merge(params || {})
    end

    def add_params(new_params)
      @params.merge!(new_params)
      self
    end

    def process
      Response.new(@client.post('/api/query/', params.merge({:w_form => form, :w_format => 'json'})))
    end

    class Response
      attr_accessor :data

      def initialize(data)
        @data = data
        populate
      end

      def success?
        return false if data.nil? || data == {}
        data['success'] == 'true'
      end

      def fail?
        return true if data.nil? || data == {}
        error.size > 0
      end

      def error
        @error || ''
      end

      def total_records
        @total_records
      end

      def records
        @records || []
      end

      private
        def populate
          @records = data["query_records"]
          @total_records = data["total_records"]
          @error    = data['error']
        end

    end
  end
end