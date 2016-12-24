class Import < ApplicationRecord
  validates :user_id, presence: true
  after_create :run_import
  belongs_to :user
  mount_uploader :data, CsvUploader
private
  def run_import
    CSV.foreach(data.current_path, headers: true) do |row|
      prospect_hash = row.to_hash
      prospect = Prospect.find_or_create_by!(user_id: prospect_hash['user_id'], campaign: prospect_hash['campaign'], list_number: prospect_hash['list_number'], source: prospect_hash['source'], company_phone: prospect_hash['company_phone'], company: prospect_hash['company'], first_name: prospect_hash['first_name'], last_name: prospect_hash['last_name'], title: prospect_hash['title'], address: prospect_hash['address'], address2: prospect_hash['address2'], city: prospect_hash['city'], state: prospect_hash['state'], zip: prospect_hash['zip'], county: prospect_hash['county'], fax: prospect_hash['fax'], numberofemployees: prospect_hash['numberofemployees'], website: prospect_hash['website'], sic: prospect_hash['sic'])
      prospect.update_attributes(prospect_hash)
    end
    self.update_column :status, 'complete'
  end
  handle_asynchronously :run_import
end
