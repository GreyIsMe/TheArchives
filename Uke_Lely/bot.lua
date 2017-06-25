local discordia = require('discordia')
local client = discordia.Client()
client.voice:loadOpus('libopus-x64')
client.voice:loadSodium('libsodium-x64')
	
client:on('ready', function()
    print('Logged in as User: '.. client.user.username)
	print('Printing Server List:')
		for guild in client.guilds do
		print(guild.name)
	end
end)

--Dev Var
dev = "251383432331001856"

--Commands
client:on('messageCreate', function(message)
	-- exit early if the author is the same as the client
	if message.author == client.user then return end

	-- split the message content into a command and everything else
	local cmd, arg = message.content:match('(%S+)%s+(.*)')
	cmd = cmd or message.content
	
	if cmd == 'u.ping' then
        message.channel:sendMessage(':ping_pong: pong!')
		print(string.format('u.ping command was used by %s', message.author.id))
	end
	
--Echo Command
	if cmd == 'u.echo' then
		message.channel:sendMessage(arg)
		print(string.format('u.echo command was used by %s to say', message.author.id))
	end
	
	if cmd == 'u.echo' then
		print(arg)
	end
	
--Info Command
	if cmd == 'u.info' then
		message.channel:sendMessage(string.format([[
Hello, I am Uke Lely,
I am a Ukelele Tuner Discord Bot made with **Lua** using **Discordia**, I am developed by Chronomly6, also I am in %s server(s).]], client.guildCount
))
		print(string.format('u.info was used by %s', message.author.id))
	end
	
--Help Command
	if cmd == 'u.help' then
		message.channel:sendMessage('Here is some help! :mailbox_with_mail:') 
	end
	
	if cmd == 'u.help' then
	message.channel:sendMessage{
  embed = {
    title = "Command List",
        fields = {
      {name = "here is the link to add the bot: ", value = [[
u.info - make the bot say something
u.info - some info 
u.ping - pings the bot
u.g - plays G
u.c - plays C
u.e - plays E
u.a - plays A
]], inline = true},
    },
    color = discordia.Color(114, 137, 218).value,
    timestamp = os.date('!%Y-%m-%dT%H:%M:%S')
  }
}
		print(string.format('u.help command was used by %s', message.author.id))
    end	
	
	if message.content == 'u.leaveserver' then
		if message.author.id == dev  then
			message.channel:sendMessage('```Error2.1``````You do not have Role: Dev```')
		end
	end

	if message.content == 'u.reboot' then
		mention = string.format('<@%s>', message.author.id)
		if message.author.id == dev  then
			message.channel:sendMessage(mention .. ' rebooting...')
			client:stop(true)
		end
		if message.author.id ~= dev  then
			message.channel:sendMessage(mention .. '```Error2.1\n---------\nYou do not have Role: Dev```')
		end
	end
	
--Music 
	
	if cmd == 'u.spawn' then
	if message.member.voiceChannel == nil then return end
		local channel = client:getVoiceChannel(message.member.voiceChannel.id) -- channel ID goes here
    	local conn = channel:join()
	end
	
	if cmd == 'u.g' then
			local channel = client:getVoiceChannel(message.member.voiceChannel.id)
	if channel == nil then
	do return end
	end
	local connection = channel:join()
	if arg == nil then
	do return end
	end
	coroutine.wrap(function()
		connection:playFile('notes/g.mp4')
		message.channel:sendMessage('Done streaming!')
		print('Done streaming!')
	end)()
	message.channel:sendMessage('Audio is streaming!')
	print(string.format("u.g command was used by %s", message.author.id))
	end
	
	if cmd == 'u.c' then
			local channel = client:getVoiceChannel(message.member.voiceChannel.id)
	if channel == nil then
	do return end
	end
	local connection = channel:join()
	if arg == nil then
	do return end
	end
	coroutine.wrap(function()
		connection:playFile('notes/c.mp4')
		message.channel:sendMessage('Done streaming!')
		print('Done streaming!')
	end)()
	message.channel:sendMessage('Audio is streaming!')
	print(string.format("u.c command was used by %s", message.author.id))
	end
	
	if cmd == 'u.e' then
			local channel = client:getVoiceChannel(message.member.voiceChannel.id)
	if channel == nil then
	do return end
	end
	local connection = channel:join()
	if arg == nil then
	do return end
	end
	coroutine.wrap(function()
		connection:playFile('notes/e.mp4')
		message.channel:sendMessage('Done streaming!')
		print('Done streaming!')
	end)()
	message.channel:sendMessage('Audio is streaming!')
	print(string.format("u.e command was used by %s", message.author.id))
	end

	if cmd == 'u.a' then
			local channel = client:getVoiceChannel(message.member.voiceChannel.id)
	if channel == nil then
	do return end
	end
	local connection = channel:join()
	if arg == nil then
	do return end
	end
	coroutine.wrap(function()
		connection:playFile('notes/a.mp4')
		message.channel:sendMessage('Done streaming!')
		print('Done streaming!')
	end)()
	message.channel:sendMessage('Audio is streaming!')
	print(string.format("u.a command was used by %s", message.author.id))
	end
	
	if cmd == 'u.play' then
			local channel = client:getVoiceChannel(message.member.voiceChannel.id)
	if channel == nil then
	do return end
	end
	local connection = channel:join()
	if arg == nil then
	do return end
	end
	coroutine.wrap(function()
		connection:playFile(arg)
		message.channel:sendMessage('Done streaming!')
		print('Done streaming!')
	end)()
	message.channel:sendMessage('Audio is streaming!')
	print(string.format("u.a command was used by %s", message.author.id))
	end
	
	



	
end)
local f = io.open("LOGIN_TOKEN", "rb")
    local content = f:read("*all")
local token = string.gsub(content, "%s+", "")
    f:close()
print(token)
client:run(token)
