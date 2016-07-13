class InitiativeImage < ActiveRecord::Base
  size_initiative_images = { medium: '300x300>', thumb: '100x100>' }
  path_initiative_images = ':rails_root/public/images/:class/:attachment/:id/:style/:filename'

  has_one :initiative

  has_attached_file :initiative_images,
                    styles: size_initiative_images,
                    path: path_initiative_images,
                    url: '/images/:class/:attachment/:id/:style/:filename',
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :initiative_images, content_type: %r{\Aimage\/.*\Z}

  scopify
end
