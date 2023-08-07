newscaster = {}

local i = 1
local duration = 2
local t = {}
--local colour = minetest.rgba(255, 0, 0, 0)
local nameserver =  minetest.colorize("red", "MTSR: ")
--local nameserver = "MTSR: "

t[1] = "Я - новостной канал"
t[2] = "Вы - игроки сервера"
t[3] = "Наша задача - играть"
t[4] = "Стройте вместе, так быстрее!"


local function printtext()
    minetest.chat_send_all(nameserver .. t[i])
    if i == #t then
        i = 1
    else
        i = i + 1
    end
    minetest.after(duration, printtext)
end
minetest.after(duration, printtext)

minetest.register_chatcommand("mtsr", {
    privs = {
        interact = true,
    },
    func = function(name, param)
        return true, "MTSR: " .. param .. "!"
    end,
})
