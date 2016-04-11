class Common < Lita::Handler
  route(/^lenny$/i) do |response|
    response.reply('( ͡° ͜ʖ ͡°)')
  end

  Lita.register_handler(self)
end
