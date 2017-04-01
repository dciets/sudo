class Common < Lita::Handler
  route(/^ici$/i) do |response|
    response.reply('et maintenant')
  end
  
  route(/ici et maintenant/i) do |response|
    response.reply('https://www.youtube.com/watch?v=DMeyvg1M52k')
  end
  
  route(/^allo allo$/i) do |response|
    response.reply('Monsieur l\'ordinateur :dorothee:')
  end
  
  route(/^lenny$/i) do |response|
    response.reply('( ͡° ͜ʖ ͡°)')
  end

  route(/^lennyorgy$/i) do |response|
    response.reply('( ͡°( ͡° ͜ʖ( ͡° ͜ʖ ͡°)ʖ ͡°) ͡°)')
  end

  route(/^montre nous tes fesses$/i, command: true) do |response|
    response.reply('( ＾◡＾)っ (‿|‿)')
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

  Lita.register_handler(self)
end
