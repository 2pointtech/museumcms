class ReprocessImages
  def self.run
    for image in Medium.all
      reprocess(image.file)
    end
  end

  def self.reprocess(image)
    image.recreate_versions!
  end
end
