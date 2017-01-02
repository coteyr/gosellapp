class CreateProspects < ActiveRecord::Migration[5.0]
  def change
    create_table :prospects do |t|
      t.string :campaign # , limit: 64
      t.integer :list_number # , limit: 10
      t.time :time_on_contact
      t.string :status # , limit: 32
      t.string :source #, limit: 32
      t.string :company #, limit: 64
      t.string :company_phone #, limit: 32
      t.string :address #, limit: 64
      t.string :address2 #, limit: 32
      t.string :city #, limit: 32
      t.string :state #, limit: 64
      t.string :zip #, limit: 16
      t.string :county #, limit: 64
      t.string :fax #, limit: 32
      t.string :website #, limit: 128
      t.string :numberofemployees #, limit: 64
      t.string :first_name #, limit: 64
      t.string :last_name #, limit: 64
      t.string :title #, limit: 64
      t.string :phone #, limit: 32
      t.string :m_phone #, limit: 32
      t.string :email #, limit: 254
      t.string :alt_email #, limit: 254
      t.string :linkedin #, limit: 128
      t.string :Facebook #, limit: 128
      t.date :born_on
      t.string :first_name_2 #, limit: 32
      t.string :last_name_2 #, limit: 64
      t.string :title_2 #, limit: 64
      t.string :phone_2 #, limit: 64
      t.string :m_phone_2 #, limit: 32
      t.string :email_2, limit: 32
      t.string :alt_email_2 #, limit: 254
      t.string :linkedin_2 #, limit: 254
      t.string :facebook_2 #, limit: 128
      t.date :born_on_2
      t.string :first_name_3 #, limit: 64
      t.string :last_name_3 #, limit: 64
      t.string :title_3 #, limit: 64
      t.string :phone_3 #, limit: 32
      t.string :m_phone_3 #, limit: 32
      t.string :email_3 #, limit: 254
      t.string :alt_email_3 #, limit: 254
      t.string :linkedin_3 #, limit: 128
      t.string :facebook_3 #, limit: 128
      t.date :born_on_3
      t.string :other1 #, limit: 64
      t.string :other2 #, limit: 64
      t.string :other3 #, limit: 64
      t.string :other4 #, limit: 64
      t.string :other5 #, limit: 64
      t.string :other6 #, limit: 64
      t.string :other7 #, limit: 64
      t.string :other8 #, limit: 64
      t.datetime :eventdatetime
      t.string :sic #, limit: 64

      t.timestamps
    end
  end
end
