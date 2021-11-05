Keyword = Struct.new(:name) do
  def to_s
    ":" + name
  end
end

class List < Array
  def to_s
    body = map{ |token| pr_str(token) }.join(" ")
    "(" + body + ")"
  end
end

class Vector < Array
  def to_s
    body = map{ |token| pr_str(token) }.join(" ")
    "[" + body + "]"
  end
end

class HashMap < Hash; end
