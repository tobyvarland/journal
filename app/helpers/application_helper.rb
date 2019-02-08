module ApplicationHelper

  # Splits search terms into array.
  def split_search_terms(input)
    search = {
      include: [],
      exclude: []
    }
    terms = input.split(/\s(?=(?:[^"]|"[^"]*")*$)/)
    terms.each do |t|
      if t[0..1] == '--'
        search[:exclude] << t[2..-1].gsub(/\A"|"\Z/, '')
      else
        search[:include] << t.gsub(/\A"|"\Z/, '')
      end
    end
    search
  end

end