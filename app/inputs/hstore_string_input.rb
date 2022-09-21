# frozen_string_literal: true

class HstoreStringInput < Formtastic::Inputs::StringInput
  include HstoreInputHelpers

  def input_html_options
    super.merge(value: hstore_field_value)
  end
end
