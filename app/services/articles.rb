class Articles
  def articles(num)
    conn = set_connection("https://www.reddit.com")
    responses = cat_subs.map do |cat_sub|
      conn.get("/r/#{cat_sub}/.json")
    end
    parse_to_article(responses, num)
  end

  def cat_subs
    %w(cats StartledCats StuffOnCats catsonglass)
  end

  def set_connection(url)
    Faraday.new(url: url) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def parse_to_article(responses, num)
    children = responses.each_with_object([]) do |response, articles|
      contents = JSON.parse(response.body)
      children(contents).each do |child|
        articles << create_article(child)
      end
    end
    children.sort_by { |child| -child.votes }[0..num]
  end

  def children(contents)
    contents["data"]["children"]
  end

  def create_article(child)
    Struct::Article.new(
      child["data"]["url"],
      child["data"]["thumbnail"],
      votes(child),
      child["data"]["title"],)
  end

  def votes(child)
    child["data"]["ups"] - child["data"]["downs"]
  end

  Struct.new("Article", :url, :image, :votes, :title)
end
