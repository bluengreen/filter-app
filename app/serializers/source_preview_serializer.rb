class SourcePreviewSerializer < ApplicationSerializer
  attributes :id, :name, :homepage_url, :lsr_active, :language, :twitter_account
  attributes :type, :url, :logo

  def url
    "#{prot}://#{Setting.host}/sources/#{object.id}-#{object.name.to_url}"
  end

  def logo
    if object.logo.present?
      "#{prot}://#{Setting.host}" + object.logo.url(:small)
    else
      nil
    end
  end

  def prot
    Setting.host['localhost'] ? 'http' : 'https'
  end
end
