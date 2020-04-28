module ApplicationHelper

  def user_avatar(user, size=128)

    img_component =
      if (user) and (!user.avatar.nil?) and user.avatar.attached?
        tag(:img,
            'data-src' => polymorphic_url(user.avatar.variant(resize_to_fill: [size, size])),
            class: 'is-rounded lazyload', id: 'upload-image')
      else
        content_tag(:div, link_to('Upload Photo',
                                  edit_user_registration_path(user)),
                    class: 'img-placeholder container-hcenters')
      end
    content_tag(:figure,
                img_component,
                class: %W(image
                          form-avatar-img-area
                          container-hcenters
                          is-#{size}x#{size}),
                id: 'upload-image'
               )
  end

  # Not lazy
  def user_avatar_nl(user, size=128)

    img_component =
      if (user) and (!user.avatar.nil?) and user.avatar.attached?
        tag(:img,
            src: polymorphic_url(user.avatar.variant(resize_to_fill: [size, size])),
            class: 'is-rounded', id: 'upload-image')
      else
        content_tag(:div, link_to('Upload Photo',
                                  edit_user_registration_path(user)),
                    class: 'img-placeholder container-hcenters')
      end
    content_tag(:figure,
                img_component,
                class: %W(image
                          form-avatar-img-area
                          container-hcenters
                          is-#{size}x#{size}),
                id: 'upload-image'
               )
  end

  def render_tags(tags)
    unless tags.nil?
      content_tag(:div,
                  tags.map { |tag|
                    content_tag(:span, tag.name, class:'tag is-rounded' ) }.reduce(&:+),
                  class: 'tags')
    end
  end

end
