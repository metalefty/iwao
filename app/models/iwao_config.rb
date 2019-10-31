class IwaoConfig < ApplicationRecord
  serialize :content

  def self.fetch(name)
    IwaoConfig.find_by(name: name)&.content
  end
end
