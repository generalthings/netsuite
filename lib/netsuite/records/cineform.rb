module NetSuite
  module Records
    class Cineform
      include FieldSupport
      include RecordSupport

      fields :custrecord_gpr_cf_product, :custrecord_gpr_cf_serial_no, :custrecord_gpr_cf_sys_code, 
      :custrecord_gpr_cf_activ_code, :custrecord_gpr_cf_code_status, :custrecord_gpr_cf_activ_count,
      :custrecord_gpr_cf_act_lev, :custrecord_gpr_cf_deact_lev, :custrecord_gpr_cf_prod_priv_key, 
      :custrecord_gpr_cf_send_key, :custrecord_gpr_cf_customer_id

      attr_reader :internal_id, :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def custom_form=(attrs)
        attributes[:custom_form] = RecordRef.new(attrs)
      end

      def entity_status=(attrs)
        attributes[:entity_status] = RecordRef.new(attrs)
      end

      def self.get(id)
        response = Actions::Get.call(id)
        if response.success?
          new(response.body)
        else
          raise RecordNotFound, "#{self} with ID=#{id} could not be found"
        end
      end

      def add
        response = Actions::Add.call(self)
        response.success?
      end

    end
  end
end
