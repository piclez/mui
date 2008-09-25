class Page

  include DataMapper::Resource
  include DataMapper::Validate
  
  property :id, Integer, :key => true, :serial => true
  property :title, String
  property :body, Text
  property :created_at, DateTime
  property :updated_at, DateTime

  validates_present(:title, :body)

end
