utilidades = require "utilidades"
pantalla_menu = require "pantallas/menu"
pantalla_partida = require "pantallas/partida"

ANCHO_VIRTUAL = 160
ALTO_VIRTUAL = 90

function love.load()
    utilidades.configuraVentana(ANCHO_VIRTUAL, ALTO_VIRTUAL)
    love.window.setTitle("rufus")
    imagen_menu_titulo = love.graphics.newImage("imgs/title.png")
    imagen_menu_texto_escritorio = love.graphics.newImage("imgs/title_letters.png")
    imagen_fondo = love.graphics.newImage("imgs/background_01.png")
    font_hud = love.graphics.newFont("fonts/pixelmix_bold.ttf", 20)    -- Fuente encontrada en: https://www.dafont.com/
    pantalla = "menu"
    high_score = 0
end

function love.update(dt)
    if pantalla == "menu" then
        pantalla_menu.update(dt)
    elseif pantalla == "partida" then
        pantalla_partida.update(dt)
    else
        -- mostrar un error (pantalla no válida)
        print("Pantalla no válida: " .. pantalla)
    end
end

function love.draw()
    utilidades.antesDeDibujar()
    
    if pantalla == "menu" then
        pantalla_menu.draw()
    elseif pantalla == "partida" then
        pantalla_partida.draw()
    end
    
    utilidades.despuesDeDibujar()
end

function love.keypressed(key)
    if pantalla == "menu" then
        pantalla_menu.se_ha_pulsado_una_tecla(key)
    elseif pantalla == "partida" then
        pantalla_partida.se_ha_pulsado_una_tecla(key)
    end
end

