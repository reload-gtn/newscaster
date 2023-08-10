newscaster = {}

local duration = 1800
local is_enable = true
local t = {}
local nameserver = minetest.colorize("cyan", "MTSR: ")

t[1] = "Заходи на главную страницу нашего сервера в интернете по адресу https://minetestserver.ru. Там сможешь узнать все последние новости сервера."
t[2] = "На сервере работает система голосований! Надоела ночь и хочешь поскорее день - набери /vote_day и голосование начнется (не забудь проголосовать сам)."
t[3] = "Я - новостной бот сервера, иногда сообщаю полезную для Вас информацию (постараюсь сильно не надоедать)."
t[4] = "Если хочется найти место для стройки поудобнее, то советую взглянуть на карту сервера https://minetestserver.ru/images/mapworld.png (периодически её обновляю)."
t[5] = "Для обсуждения игровых (и нетолько) вопросов советую наш телеграм канал https://t.me/MinetestServerRu. Задавайте свои вопросы администрации и другим игрокам (надеюсь они смогут ответить)."
t[6] = "Предупреждаю, что направленность сервера техническая, по этому советую детально разбираться что к чему, чтобы остаться и развиваться, а не уходить на другие (у нас хорошо, точно не хуже)."
t[7] = "Сломался инструмент? Устал крафтить его каждый раз заново и жалко на это ресурсов? - Воспользуйся наковальней и молотом, чтобы его отремонтировать (в поиске предметов введи anvil, дальше станет понятно как действовать)."
t[8] = "Маленький секрет, у игрока может быть два дома: один - из меню инвентаря, второй - по командам чата /sethome и /home. Используй с пользой."
t[9] = "Игроки часто спрашивают, кто их убивает и почему они умирают. Отвечаю - голод, тут надо его восполнять и питаться (так и здоровье пополнется)."
t[10] = "Едой на первое время могут стать плоды на деревьях и земле, а также автомат по выдаче бесплатных печенек рядом со спавном (спасибо Karabas-у)."
t[11] = "На сервере присутствует денежная система, играя - ты зарабатываешь виртуальную валюту (банкноты). Их можно тратить с пользой в магазинах пользователей (можешь откырыть свой, за рекламой обращайся к администрации)"
t[12] = "У нас тут можно заниматься садоводством, для этого все, растения, удобрения и фермы!"
t[13] = "Советую заглянуть на садоводческую ферму Arid-а возле спавна, там много чего есть, ассортимент стоящий, а цены - низкие!"
t[14] = "Накопил много семян, нужно быстро получить урожай? Воспользуйся общественной фермой у спавна (большое поле, осещение, мельница для хлеба рядом)! Либо посади и оставь для других, они скажут тебе спасибо."
t[15] = "Играешь, играешь и играешь..., а результата нет - кирка до сих пор деревянная или из булыжника, страшишься мобов и других игроков? Узнай как развиться и начать прокачку - Курс 'Молодым бойцам' от Karabas-а поможет в этом (находи его обучающие локации и незабудь отблагодарить)."
t[16] = "Обычно я закупаюсь необходимым в Магазине Preservoir-a на спавне, там много ценного для прокачки, да и есть возможность подзаработать, сдав свой булыжник в магазин за денежное вознаграждение!"
t[15] = "Вот что-что, а сервер наш бесплатный, мы не приветствуем никакой игровой донат, продажу/покупку аккаунтов - это запрещено."
t[16] = "Играть тут могут все, кто угодно и из любой страны, сам севрер и его администрация в России, русский и английский язык для общения приветсвуются. Давайте всегда уважать друг друга."
t[17] = "Нужно много древесины? Ужас, сколько деревьев наросло, не пройти! Используй автоматическую рубку, зажав клавишу кнопку 'красться'!"
t[18] = "Не забывай защищать свои постройки и несметные богатсва, используй защиту всевозможную защиту (введи protect в поиске предметов, посмотри что там есть для этого)."
t[19] = "Надоело выглядеть как все? Смени свой скин, надень броню!"
t[20] = "Гриферсвто - дело не благодарное, а еще и наказуемое. Смотри, я предупредил."
t[21] = "Есть идеи, как улучшить сервер и разнообразить его - высказывай их смело, всё рассмотрим и обсудим."
t[22] = "Активных игроков сервера, которые чем-то полезны для других игроков и самого сервера мы очень ценим, поощряем и выделяем (да хоть личным префиксом к имени игрока). Попробуй и ты стать таким."
t[23] = "Мы строим всё силами обычных игроков, без дополнительных прав по модификации мира и креатива. Да что говорить, тут даже админ - обычный игрок."
t[24] = "Я устал, немного помолчу..."

local function print_news()
    minetest.chat_send_all(nameserver .. t[math.random(1,#t)])
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
        creative = true,
    },
    func = function(name, param)
        return true, "Интервал новостного бота установлен на " .. param .. " секунд",
            set_duration(param)
    end,
})

minetest.register_chatcommand("newscaster_disable", {
    privs = {
        creative = true,
    },
    func = function(name, param)
        return true, "Новостной бот отключен", set_is_enable(false)
    end
})

minetest.register_chatcommand("newscaster_enable", {
    privs = {
        creative = true,
    },
    func = function(name, param)
        return true, "Новостной бот включен", set_is_enable(true), minetest.after(duration, print_news)
    end
})
