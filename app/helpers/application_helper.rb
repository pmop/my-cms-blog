module ApplicationHelper

  def user_avatar(user, size=128)

    img_component =
      if (user) and user.avatar.attached?
        tag(:img,
            'data-src' => polymorphic_url(user.avatar.variant(resize: "#{size}x#{size}")),
            class: 'is-rounded lazyload')
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
                          is-#{size}x#{size})
               )
  end
end
