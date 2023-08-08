newscaster = {}

local i = 1
local duration = 2
local is_enable = true
local t = {}
local nameserver = minetest.colorize("red", "MTSR: ")

t[1] = "Заходи на главной страницу нашего сервера в интернете по адресу htttps://minetestserver.ru"
t[2] = "На сервере работает система голосования! Хочешь день, набери /vote_day и начнется голосование"
t[3] = "Наша задача - играть"
t[4] = "Стройте вместе, так быстрее!"


local function print_news()
    minetest.chat_send_all(nameserver .. t[i])
    if i == #t then
        i = 1
    else
        i = i + 1
    end
    if is_enable then
        minetest.after(duration, print_news)
    end
end

local function set_duration(value)
    duration = value
end

local function set_is_enable(value)
    is_enable = value
end

minetest.after(duration, print_news)

minetest.register_chatcommand("newscaster_duration", {
    privs = {
        interact = true,
    },
    func = function(name, param)
        return true, "Интервал новостного бота установлен на " .. param .. " секунд",
            set_duration(param)
    end,
})

minetest.register_chatcommand("newscaster_disable", {
    privs = {
        interact = true,
    },
    func = function(name, param)
        return true, "Новостной бот отключен", set_is_enable(false)
    end
})

minetest.register_chatcommand("newscaster_enable", {
    privs = {
        interact = true,
    },
    func = function(name, param)
        return true, "Новостной бот включен", set_is_enable(true), minetest.after(duration, print_news)
    end
})
