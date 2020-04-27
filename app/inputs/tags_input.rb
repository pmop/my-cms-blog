class TagsInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    @input_html_options[:type] = 'tags'
    # @input_html_options[:value] = 'Untagged'
    merged_input_options = merge_wrapper_options(@input_html_options, wrapper_options)

    "#{@builder.text_field(attribute_name, merged_input_options)}".html_safe
  end
end
