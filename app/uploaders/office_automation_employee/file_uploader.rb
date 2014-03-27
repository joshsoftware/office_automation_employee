# encoding: utf-8
module OfficeAutomationEmployee
  class FileUploader < CarrierWave::Uploader::Base

    include CarrierWave::RMagick

    version :rectangle, if: :is_logo?
    version :square, if: :is_logo?
    version :normal, if: :is_image?
    version :thumb, if: :is_image?
    version :small, if: :is_image?

    # Choose what kind of storage to use for this uploader:
    storage :file
    # storage :fog

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    # Provide a default URL as a default if there hasn't been a file uploaded:
    def default_url
      ActionController::Base.helpers.asset_path("office_automation_employee/fallback/" + [version_name, "default.png"].compact.join('_'))
    end

    # Process files as they are uploaded:
    # process :scale => [200, 300]
    #
    # def scale(width, height)
    #   # do something
    # end

    # Create different versions of your uploaded files:
    version :thumb do
      process resize_to_fit: [60, 60]
    end

    version :square do
      process resize_to_fit: [60, 60]
    end

    version :normal do
      process resize_to_fit: [120,120]
    end

    version :small do
      process resize_to_fit: [35,35]
    end

    version :rectangle do
      process resize_to_fit: [60,200]
    end

    # Add a white list of extensions which are allowed to be uploaded.
    # For images you might use something like this:
    def extension_white_list
      %w(jpg jpeg gif png)
    end
    
    protected

    def is_logo? picture
      model.instance_of? Company
    end

    def is_image? picture
      model.instance_of? User
    end
  end
end
