class Page < MuiPage::Pages

  include DataMapper::Resource
  
  property :id, Integer, :serial => true
  property :label, String
  property :value, Text
  property :created_at, DateTime
  property :updated_at, DateTime

end
