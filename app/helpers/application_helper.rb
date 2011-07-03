module ApplicationHelper

  # replace swears
  def swear_generator(text)
    return if text.blank?
    # swear nouns
    if !@diswnouns
      if Rails.cache.read("diswnouns").nil?
        @diswnouns                      = Redact.where(:code_name => 'diswnouns').first.redact_array 
        Rails.cache.write("diswnouns", @diswnouns)
      else
        @diswnouns                      = Rails.cache.read("diswnouns")
      end
    end
    text.gsub!('#diswnoun#', @diswnouns.sample)

    # simple swear nouns
    if !@diswnouns_simp
      if Rails.cache.read("diswnouns_simp").nil?
        @diswnouns_simp                      = Redact.where(:code_name => 'diswnouns-simp').first.redact_array 
        Rails.cache.write("diswnouns_simp", @diswnouns_simp)
      else
        @diswnouns_simp                      = Rails.cache.read("diswnouns_simp")
      end
    end
    text.gsub!('#diswnoun-simp#', @diswnouns_simp.sample)
    
    # swear adjectives
    if !@diswadjs
      if Rails.cache.read("diswadjs").nil?
        @diswadjs                      = Redact.where(:code_name => 'diswadjs').first.redact_array 
        Rails.cache.write("diswadjs", @diswadjs)
      else
        @diswadjs                      = Rails.cache.read("diswadjs")
      end
    end
    text.gsub!('#diswadj#', @diswadjs.sample)
    
    # simple swear adjectives
    if !@diswadjs_simp
      if Rails.cache.read("diswadjs_simp").nil?
        @diswadjs_simp                      = Redact.where(:code_name => 'diswadjs-simp').first.redact_array 
        Rails.cache.write("diswadjs_simp", @diswadjs_simp)
      else
        @diswadjs_simp                      = Rails.cache.read("diswadjs_simp")
      end
    end 
    text.gsub!('#diswadj-simp#', @diswadjs_simp.sample)
    
    # image replacement
    text.gsub! /#diswimage(.)+#/ do |image_text|
      diswimage(image_text)
    end
    
    return text
  end
  
  # display text using Textile
  def textilize(text)  
    text  = swear_generator(text)
    RedCloth.new(text).to_html.html_safe unless text.blank?  
  end
  
  # generate random image tag
  # e.g., #diswimage:boggle:png:5:300#
  # for boggle-(n).png, n = 1 - 5, height: 300px
  # options: [0] => title, [1] => file extension, [2] => number of options, [3] => width in pixels
  def diswimage(image_text)
    image_options   = image_text.gsub(/#/, '').gsub(/diswimage:/, '').split(':')
    image_title     = image_options[0]
    image_extension = image_options[1]
    option_count    = image_options[2]
    image_width     = image_options[3]
    return "!{width: #{image_width}px}http://doitidiot.s3.amazonaws.com/#{image_title}-#{rand(option_count)+1}.#{image_extension}!"
  end
  

  # redact certain blacklisted words
  def redactor(text)
    if !@blacklist
      if Rails.cache.read("blacklist").nil?
        @blacklist                      = Redact.where(:code_name => 'blacklist').first.redact_array 
        Rails.cache.write("blacklist", @blacklist)
      else
        @blacklist                      = Rails.cache.read("blacklist")
      end
    end
    @blacklist.each do |b|
      text  = text.gsub(Regexp.new(b, true), "[REDACTED]")
    end
    if !@emoticons
      if Rails.cache.read("emoticons").nil?
        @emoticons                      = Redact.where(:code_name => 'emoticons').first.redact_array 
        Rails.cache.write("emoticons", @emoticons)
      else
        @emoticons                      = Rails.cache.read("emoticons")
      end
    end
    @emoticons.each do |e|
      text  = text.gsub(e, ":(")
    end
    return text
  end

end
