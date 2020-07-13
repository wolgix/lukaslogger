resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Server Logging'

version '1.0'

--server_script 'server.lua'
client_scripts {
	"client.lua",
}

--edit and cleand up by NebelRebell
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@FiveMIdentifierLogger',
	'server.lua',
}
