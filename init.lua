newscaster = {}

print("Start mod newscaster at load time server!")
minetest.chat_send_all("This is a chat message to all players")
minetest.register_chatcommand("mtsr", {
    privs = {
        interact = true,
    },
    func = function(name, param)
        return true, "MTSR: " .. param .. "!"
    end,
})