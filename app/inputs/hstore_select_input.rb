# frozen_string_literal: true

class HstoreSelectInput < Formtastic::Inputs::SelectInput
  def input_options
    super.merge(selected: hstore_field_value)
  end

  private

  def hstore_field_value
    parent[parent_field_name].try(:[], method.to_s)
  end

  def parent
    builder.options[:parent_builder].object
  end

  def parent_field_name
    object_name.match(/\[(\w+)\]/)[1]
  end
end
