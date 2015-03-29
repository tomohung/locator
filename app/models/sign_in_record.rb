class SignInRecord < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :latitude, :longitude

  def search_nearest_records(distance = nil)
    records = SignInRecord.all.sort_by { |record| record.get_distance(latitude, longitude) }
    return records.shift(10) if distance.nil?

    records.select { |record| record.get_distance(latitude, longitude) < distance }
  end

  def get_distance(lat, lng)
    # http://blog.csdn.net/mad1989/article/details/9933089
    lat1 = (Math::PI/180) * latitude.to_f;
    lat2 = (Math::PI/180) * lat.to_f;

    lon1 = (Math::PI/180) * longitude.to_f;
    lon2 = (Math::PI/180) * lng.to_f;

    earth_radius = 6371;
    d =  Math.acos(Math.sin(lat1) * Math.sin(lat2) + Math.cos(lat1) * Math.cos(lat2) * Math.cos(lon2 - lon1)) * earth_radius;
    return d;
  end
end