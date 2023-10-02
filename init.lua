newscaster = {}

--интервал новостей
local duration = 1800
--состояние новостей (вкл/выкл)
local is_enable = true
--состояние анонса ивента (вкл/выкл)
local is_event_enable = false
--массив новостей
local news_massive = {}
--массив анекдотов
local funny_massive = {}
--строка с описание ивента
local event
--номер новостной базы
local nubmer_base = 1
--имя бота сервера
local nameserver = minetest.colorize("cyan", "MTSR(бот): ")
--адрес мода, путь
local path = minetest.get_modpath("newscaster")
--файлы с новостями и анекдотов, ивент
local file_news = io.lines(path .. "/news.txt", "r")
local file_funny = io.lines(path .. "/funny.txt", "r")
local file_event = io.open(path .. "/event.txt", "r")

--чтение файлов с новостями и заполнение массива новостей
for line in file_news do
    news_massive[#news_massive + 1] = line
end

--чтение файлов с анекдотами и заполнение массива анекдотов
for line in file_funny do
    funny_massive[#funny_massive + 1] = line
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
    if nubmer_base == 1 then
    minetest.chat_send_all(nameserver .. news_massive[math.random(1, #news_massive)])
    nubmer_base = 2
    else 
        minetest.chat_send_all(nameserver .. minetest.colorize("green", "Шутка часа - ") .. funny_massive[math.random(1, #funny_massive)])
        nubmer_base = 1
    end
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

--функция добавления анекдота в массив
local function add_funny(value)
    description = "Добавление анекдота в базу"
    funny_massive[#funny_massive + 1] = value
end

--функция установки интервала новостей
local function set_duration(value)
    duration = value
end

--функция обновления (чтения) новостей из файлов
local function update_base()
    event = read_event_file(path .. "/event.txt")
    news_massive = {}
    for line in io.lines(path .. "/news.txt", "r") do
        news_massive[#news_massive + 1] = line
    end
    funny_massive = {}
    for line in io.lines(path .. "/funny.txt", "r") do
        funny_massive[#funny_massive + 1] = line
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

--команда чата для установки интервала новостей
minetest.register_chatcommand("newscaster_duration", {
    description = "Установка интервала вещания бота",
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
    description = "Отключение бота",
    privs = {
        server = true,
    },
    func = function(name, param)
        return true, "Новостной бот отключен", set_is_enable(false)
    end
})

--команда чата для включения бота
minetest.register_chatcommand("newscaster_enable", {
    description = "Включение бота",
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
    description = "Включение анонса ивента",
    privs = {
        server = true,
    },
    func = function(name, param)
        return true, "Анонс ивента включен", set_is_event_enable(true)
    end
})

--команда чата для отключения анонса ивента
minetest.register_chatcommand("newscaster_event_disable", {
    description = "Отключение анонса ивента",
    privs = {
        server = true,
    },
    func = function(name, param)
        return true, "Анонс ивента выключен", set_is_event_enable(false)
    end
})

--команда чата для добавления новости в массив
minetest.register_chatcommand("newscaster_addnews", {
    description = "Добавление новости в базу",
    privs = {
        server = true,
    },
    func = function(name, param)
        return true, "Новость добавлена", add_news(param)
    end
})

--команда чата для добавления анекдота в массив
minetest.register_chatcommand("newscaster_addfunny", {
    description = "Добавление анекдота в базу",
    privs = {
        server = true,
    },
    func = function(name, param)
        return true, "Анекдот добавлен", add_funny(param)
    end
})

-- команда чата вернуть общее число новостей и анекдотов в базах
minetest.register_chatcommand("newscaster_size", {
    description = "Общее число новостей и анекдотов",
    privs = {
        interact = true,
    },
    func = function(name, param)
        return true, "Общее число новостей и анекдотов - " .. #news_massive+#funny_massive
    end
})

-- команда чата обновить базы
minetest.register_chatcommand("newscaster_updatebase", {
    description = "Обновление баз новостей и анекдотов",
    privs = {
        server = true,
    },
    func = function(name, param)
        return true, "Новости  обновлены", update_base()
    end
})

-- вызов функции рекурсии с публикацией новости
minetest.after(duration, print_news)
