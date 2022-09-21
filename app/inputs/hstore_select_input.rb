# frozen_string_literal: true

class HstoreSelectInput < Formtastic::Inputs::SelectInput
  include HstoreInputHelpers

  def input_options
    super.merge(selected: hstore_field_value)
  end
end
