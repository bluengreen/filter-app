# == Schema Information
#
# Table name: sources
#
#  id                            :integer          not null, primary key
#  type                          :string(255)
#  url                           :string(255)
#  name                          :string(255)
#  value                         :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  logo_file_name                :string(255)
#  logo_content_type             :string(255)
#  logo_file_size                :integer
#  logo_updated_at               :datetime
#  full_text_selector            :string(255)
#  error                         :boolean
#  multiplicator                 :float            default(1.0)
#  lsr_active                    :boolean          default(FALSE)
#  deactivated                   :boolean          default(FALSE)
#  default_category_id           :integer
#  lsr_confirmation_file_name    :string
#  lsr_confirmation_content_type :string
#  lsr_confirmation_file_size    :integer
#  lsr_confirmation_updated_at   :datetime
#  twitter_account               :string
#  language                      :string
#  comment                       :text
#  filter_rules                  :text
#  statistics                    :json
#  error_message                 :text
#

class FeedSource < Source
  self.description = <<~DOC
    An RSS / Atom feed is known. In addition, a full_text_selector is used 
    to download the complete description from the teaser texts.
    Important for correct categorization / search
  DOC
  validates_uniqueness_of :url
  validates :twitter_account, format: { with: /\A\w+\z/ }, if: :twitter_account?

  def should_fetch_stats?(ni)
    true
  end

  def refresh
    FeedProcessor.process(self)
    # old.map{|i|NewsItem.find(i).destroy}
    true
  end
end
