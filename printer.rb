require_relative "types"

def pr_str(mal_object)
  case mal_object
  when Symbol, Integer, Float, Keyword, List, Vector, true, false, nil
    mal_object.to_s
  when HashMap
    body = []
    mal_object.each do |key, value|
      body << pr_str(key)
      body << pr_str(value)
    end
    "{" + body.join(" ") + "}"
  when String
    mal_object.inspect
  else
    raise NotImplementedError.new("#{mal_object.class.name} is not printable")
  end
end
