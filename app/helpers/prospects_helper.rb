module ProspectsHelper
  def primary_contact(prospect, method)
    if prospect.primary_contact == 3
      return prospect.send("#{method}_3")
    elsif prospect.primary_contact == 2
      return prospect.send("#{method}_2")
    else
      return prospect.send("#{method}")
    end
  end
end
