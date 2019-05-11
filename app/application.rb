class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    elsif req.path.match(/add/)
      to_add = req.params["item"]
      resp.write handle_add(to_add)

      @@cart << to_add

    elsif req.path.match(/cart/)
      if @@cart == [] then resp.write "Your cart is empty" end

      @@cart.each do |item|
      resp.write "#{item}\n"
      end
      
    else
      resp.write "Path Not Found"
    end
    #if @@cart == [] then puts "Your cart is empty" end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def handle_add(search_term)
    if @@items.include?(search_term)
      return "added #{search_term}"
    else
      return "We don't have that item"
    end
  end

end

#ace = Application.new
#ace.call("p")