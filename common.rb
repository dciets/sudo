# coding: utf-8

require 'base64'
require 'net/http'

class Common < Lita::Handler
  route(/^xor ([^ ]+) ([^ ]+)/i) do |response|
    begin
      data = Base64.decode64(response.args[0])
      key = Base64.decode64(response.args[1])

      output = data.bytes.zip(key.bytes.cycle).map { |x|
        x.reduce(:^).chr
      }.join

      response.reply(output.inspect)
    rescue
      response.reply("Usage: xor [base64 data] [base64 key]")
    end
  end

  route(/^ici$/i) do |response|
    response.reply('et maintenant')
  end

  route(/ici et maintenant/i) do |response|
    response.reply('https://www.youtube.com/watch?v=DMeyvg1M52k')
  end

  route(/^allo allo$/i) do |response|
    if Time.new.to_i.even?
      response.reply('Monsieur l\'ordinateur :dorothee:')
    else
      phrases = ['Just pick up the phone', 'I wonder what they wanna know', 'They wanna know, comme allo allo', 'I just wanna let you know']
      response.reply(phrases.sample + ' :telephone_receiver:')
    end
  end

  route(/^lenny$/i) do |response|
    response.reply(':lenny1::lenny2:')
  end

  route(/^lennyorgy$/i) do |response|
    response.reply(':lenny1::lenny1::lenny1::lenny2::lenny2::lenny2:')
  end

  route(/^8ball/i, command: true) do |response|
    phrases = ['It is certain', 'It is decidedly so', 'Without a doubt', 'Yes definitely', 'You may rely on it', 'As I see it, yes', 'Most likely', 'Outlook good', 'Yes', 'Signs point to yes', 'Reply hazy try again', 'Ask again later', 'Better not tell you now', 'Cannot predict now', 'Concentrate and ask again', 'Don\'t count on it', 'My reply is no', 'My sources say no', 'Outlook not so good', 'Very doubtful']
    response.reply(phrases.sample + ' :8ball:')
  end

  route(/^montre nous tes fesses$/i, command: true) do |response|
    response.reply('( ＾◡＾)っ (‿|‿)')
  end

  route(/^koi$/i, command: true) do |response|
    response.reply("Je revenais de faire mon voyage de coopération internationale au Sénégal et les filles du groupe me l'on créé ... Confit pour confiture, parce que se salué dans le dialecte cerrer-lala tu dit \"jammm\" comme confiture en anglais et le phil c'était parce que mon nom d'adoption au Sénégal c'était Philippe")
  end

  route(/^Je revenais de faire mon voyage de coopération internationale au Sénégal et les filles du groupe me l'on créé ... Confit pour confiture, parce que se salué dans le dialecte cerrer-lala tu dit \"jammm\" comme confiture en anglais et le phil c'était parce que mon nom d'adoption au Sénégal c'était Philippe$/i, command: false) do |response|
    response.reply("koi")
  end

  route(/^:arrow_up: :arrow_up: :arrow_down: :arrow_down: :arrow_left: :arrow_right: :arrow_left: :arrow_right: :b: :a:$/i) do |response|
    response.reply(":fireworks: Thanks, this Slack workspace has been upgraded to a PREMIUM workspace :fireworks:")
  end

  route(/^\+1( :[\w\-\+:]+:)?( :[\w\-\+:]+:)?$/, command: true) do |response|
    message = '''_0__0__0__0__0__0__0__0__0__0_
_0__0__0__0__0__0__1__0__0__0_
_0__0__0__0__0__1__1__0__0__0_
_0__0__1__0__0__0__1__0__0__0_
_0__1__1__1__0__0__1__0__0__0_
_0__0__1__0__0__0__1__0__0__0_
_0__0__0__0__0__0__1__0__0__0_
_0__0__0__0__0__1__1__1__0__0_
_0__0__0__0__0__0__0__0__0__0_'''

    message.gsub!(/_0_/, response.args[0] || ':ship:')
    message.gsub!(/_1_/, response.args[1] || ':+1:')
    response.reply(message)
  end

  route(/^-1( :[\w\-\+:]+:)?( :[\w\-\+:]+:)?$/, command: true) do |response|
    message = '''_0__0__0__0__0__0__0__0__0__0_
_0__0__0__0__0__0__1__0__0__0_
_0__0__0__0__0__1__1__0__0__0_
_0__0__0__0__0__0__1__0__0__0_
_0__1__1__1__0__0__1__0__0__0_
_0__0__0__0__0__0__1__0__0__0_
_0__0__0__0__0__0__1__0__0__0_
_0__0__0__0__0__1__1__1__0__0_
_0__0__0__0__0__0__0__0__0__0_'''

    message.gsub!(/_0_/, response.args[0] || ':ship:')
    message.gsub!(/_1_/, response.args[1] || ':-1:')
    response.reply(message)
  end


  LATEX_URL = URI::HTTP.build(host: 'chart.apis.google.com', path: '/chart', fragment:'.png').freeze

  route %r(\A(?:tex|latex)(?:\s+me)?\s+(.*)\Z), :latex, command: true do
    expression = CGI.escape(response.matches.first.first)
    response.reply image_url(expression)
  end

  route(/countdown/i, command: false) do |response|
    count = (Date.new(2019, 03, 22) - Date.today).to_i
    if count > 1
      response.reply ":cs-games: *#{count} jours* avant les CS Games :cs-games:"
    elsif count == 1
      response.reply ":cs-games: :hypnotroll: :pogslide: C'EST DEMAIN! :pogslide: :hypnotroll: :cs-games:"
    elsif count >= -2
      response.reply ":cs-games: :hypnotroll: :pogslide: C'EST AUJOURD'HUI! :pogslide: :hypnotroll: :cs-games:"
    else
      response.reply ":cs-games: Les CS reviennent l'année prochaine! :cs-games:"
    end
  end

  route(/^kebac (.+)$/i, command: true) do |response|
    expression = response.args.join(' ')
    response.reply fetch_kebac(expression)
  end

  Lita.register_handler(self)

  private

  def image_url(expression)
    LATEX_URL.dup.tap { |url|
      url.query = "cht=tx&chl=#{ expression }"
    }.to_s
  end

  def fetch_kebac(expression)
    uri = URI('https://agile-scrubland-53958.herokuapp.com')
    uri.query = URI.encode_www_form({ :french => expression })
    response = Net::HTTP.get_response(uri)
  
    case response
    when Net::HTTPSuccess then
      response.body
    else
      'leu sairver neu répon pa ¯\_(ツ)_/¯'
    end
  end

end
