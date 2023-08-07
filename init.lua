print("This file will be run at load time!")

minetest.register_node("newscaster:node", {
    description = "This is a node",
    tiles = { "newscaster_node.png" },
    groups = { cracky = 1 }
})

minetest.register_craft({
    type = "shapeless",
    output = "newscaster:node 3",
    recipe = { "default:dirt", "default:stone" },
})
