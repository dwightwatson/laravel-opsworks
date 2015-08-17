case node[:platform]
when "redhat", "centos", "fedora"
  package "ImageMagick"
when "debian", "ubuntu"
  package "imagemagick"
end