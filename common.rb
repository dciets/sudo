class Common < Lita::Handler
  route(/^lenny$/i) do |response|
    response.reply('( ͡° ͜ʖ ͡°)')
  end

  route(/^lennyorgy$/i) do |response|
    response.reply('( ͡°( ͡° ͜ʖ( ͡° ͜ʖ ͡°)ʖ ͡°) ͡°)')
  end

  route(/^montre nous tes fesses$/i, command: true) do |response|
    response.reply('( ＾◡＾)っ (‿|‿)')
  end

  route(/^uber\+1$/, command: true) do |response|
    message = ''':inbefore::inbefore::inbefore::inbefore::inbefore::inbefore::inbefore::inbefore::inbefore::inbefore:
:inbefore::inbefore::inbefore::inbefore::inbefore::inbefore::+1::inbefore::inbefore::inbefore:
:inbefore::inbefore::inbefore::inbefore::inbefore::+1::+1::inbefore::inbefore::inbefore:
:inbefore::inbefore::+1::inbefore::inbefore::inbefore::+1::inbefore::inbefore::inbefore:
:inbefore::+1::+1::+1::inbefore::inbefore::+1::inbefore::inbefore::inbefore:
:inbefore::inbefore::+1::inbefore::inbefore::inbefore::+1::inbefore::inbefore::inbefore:
:inbefore::inbefore::inbefore::inbefore::inbefore::inbefore::+1::inbefore::inbefore::inbefore:
:inbefore::inbefore::inbefore::inbefore::inbefore::+1::+1::+1::inbefore::inbefore:
:inbefore::inbefore::inbefore::inbefore::inbefore::inbefore::inbefore::inbefore::inbefore::inbefore:'''

    response.reply(message)
  end

  Lita.register_handler(self)
end
