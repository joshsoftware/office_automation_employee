module OfficeAutomationEmployee
  class Attachment
    include Mongoid::Document
    include Mongoid::Timestamps::Created 
   
    mount_uploader :document, DocumentUploader

    field :name
    field :document

    embedded_in :user, class_name: 'OfficeAutomationEmployee::User'

    validate :document_size

    def document_size
      if document.file.size > 10.megabytes
        errors.add(:document, "you cannot upload a file greater than 10 MB")
      end
    end
  end
end
