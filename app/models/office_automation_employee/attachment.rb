module OfficeAutomationEmployee
  class Attachment
    include Mongoid::Document

    mount_uploader :document, DocumentUploader

    field :name
    field :document

    embedded_in :user, class_name: 'OfficeAutomationEmployee::User'

    validate :document_size

    def document_size
      if document.file.size > 5.megabytes
        errors.add(:document, "you cannot upload a file greater than 5 MB")
      end
    end
  end
end
