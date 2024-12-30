import xmlrpclib

server = xmlrpclib.ServerProxy("https://cruise:cruise@zeus.local/projects/diabdiary/login/xmlrpc")

multicall = xmlrpclib.MultiCall(server)

ticket = server.ticket.get(1)
multicall.ticket.status.get('new')

multicall.ticket.getAvailableActions(1)

print map(str, multicall())
