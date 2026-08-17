return function(mod)

  mod.content.pokemon:patch("PIKACHU", {
    evolutions = { __append = { { method = "ITEM", item = "MOON_STONE", species = "CLEFAIRY" } } },
  })

  local evolveSound = mod.assets:path("assets/clefairy.ogg")
  local muteUntil = nil

  mod.hooks:wrap("music.volume", function(next, vol, ctx)
    if muteUntil and love.timer.getTime() < muteUntil then
      return 0
    end
    return next(vol, ctx)
  end)

  mod.events:on("pokemon.evolved", function(ev)
    if ev.fromSpecies == "PIKACHU" and ev.toSpecies == "CLEFAIRY" then
      muteUntil = love.timer.getTime() + 6
      local ok, src = pcall(love.audio.newSource, evolveSound, "static")
      if ok then
        src:play()
      end
    end
  end)

end
