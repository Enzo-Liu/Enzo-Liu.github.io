# @param {Integer[][]} points
# @return {Integer}
def find_min_arrow_shots(points)
  scope = nil
  res = 0
  points.sort { |p1,p2| p1[0]<=>p2[0]}.each do |p|
    if (scope == nil)
      scope = p
      res = res + 1
    elsif (p[0] <= scope[1])
      scope = [[p[0],scope[0]].max, [p[1], scope[1]].min]
    else
      scope = [p[0],p[1]]
      res = res + 1
    end
  end
  res
end
