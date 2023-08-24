newscaster = {}

--интервал новостей
local duration = 1800
--состояние новостей (вкл/выкл)
local is_enable = true
--состояние анонса ивента (вкл/выкл)
local is_event_enable = false
--массив новостей
local news_massive = {}
--строчка с описание ивента
local event
--имя бота сервера
local nameserver = minetest.colorize("cyan", "MTSR(бот): ")
--адрес мода, путь
local path = minetest.get_modpath("newscaster")
--файл с новостями
local file_news = io.lines(path .. "/news.txt", "r")
local file_event = io.open(path .. "/event.txt", "r")

--чтение файлов с новостями и заполнение массива новостей
for line in file_news do
    news_massive[#news_massive + 1] = line
end

--функция чтение строчки с ивентом из файла
local function read_event_file(path)
    local F = io.open(path)
    local TEXT = F:read()
    F:close()
    return TEXT
 end

--чтение ивента
event = read_event_file(path .. "/event.txt")

--функция вызова новостей в чат
local function print_news()
    minetest.chat_send_all(nameserver .. news_massive[math.random(1, #news_massive)])
    if is_enable then
        minetest.after(duration, print_news)
        if is_event_enable then
            minetest.chat_send_all(nameserver .. minetest.colorize("darkred", event))
        end
    end
end

--функция добавления новости в массив
local function add_news(value)
    news_massive[#news_massive + 1] = value
end

--функция установки интервала новостей
local function set_duration(value)
    duration = value
end

--функция обновления (чтения) новостей из файла news.txt
local function update_base()
    event = read_event_file(path .. "/event.txt")
    news_massive = {}
    for line in io.lines(path .. "/news.txt", "r") do
        news_massive[#news_massive + 1] = line
    end
end

--функция включения бота
local function set_is_enable(value)
    is_enable = value
end

--функция включения анонса ивента
local function set_is_event_enable(value)
    is_event_enable = value
end


--команда чата для установки интервала
minetest.register_chatcommand("newscaster_duration", {
    privs = {
        server = true,
    },
    func = function(name, param)
        return true, "Интервал новостного бота установлен на " .. param .. " секунд",
            set_duration(param)
    end,
})

--команда чата для отключения бота
minetest.register_chatcommand("newscaster_disable", {
    privs = {
        server = true,
    },
    func = function(name, param)
        return true, "Новостной бот отключен", set_is_enable(false)
    end
})

--команда чата для включения бота
minetest.register_chatcommand("newscaster_enable", {
    privs = {
        server = true,
    },
    func = function(name, param)
        return true, "Новостной бот включен", set_is_enable(true),
            minetest.after(duration, print_news)
    end
})

--команда чата для включения анонса ивента
minetest.register_chatcommand("newscaster_event_enable", {
    privs = {
        server = true,
    },
    func = function(name, param)
        return true, "Анонс ивента включен", set_is_event_enable(true)
    end
})

--команда чата для отключения анонса ивента
minetest.register_chatcommand("newscaster_event_disable", {
    privs = {
        server = true,
    },
    func = function(name, param)
        return true, "Анонс ивента выключен", set_is_event_enable(false)
    end
})

--команда чата для добавления новости в массив
minetest.register_chatcommand("newscaster_addnews", {
    privs = {
        server = true,
    },
    func = function(name, param)
        return true, "Новость добавлена", add_news(param)
    end
})

-- команда чата вернуть общее число новостей в базе
minetest.register_chatcommand("newscaster_size", {
    privs = {
        server = true,
    },
    func = function(name, param)
        return true, "Общее число новостей - " .. #news_massive
    end
})

-- команда чата обновлить базу из файла
minetest.register_chatcommand("newscaster_updatebase", {
    privs = {
        server = true,
    },
    func = function(name, param)
        return true, "Новости  обновлены", update_base()
    end
})

-- вызов функции рекурсии с публикации новости
minetest.after(duration, print_news)
