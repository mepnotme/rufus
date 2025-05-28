local menu = {
    update = function(dt)
        -- lógica del menú
    end,
    draw = function()
        -- dibujamos el frame del menú
        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(imagen_menu_titulo, 0, 0)

        if mobile then
            --love.graphics.print("- espacio para jugar -", 20, 80)
            love.graphics.draw(imagen_menu_texto_movil, 0, 0)
        else
            love.graphics.draw(imagen_menu_texto_escritorio, 0, 0)
        end
    end,
    se_ha_pulsado_una_tecla = function(tecla)
        if tecla == "space" then
            pantalla = "partida"
            -- inicializamos la partida
            heroe = require "objetos/heroe"
            heroe.velocidad = 100 -- velocidad con la que corre inicialmente del héroe (en píxeles por segundo)
            tiempo_partida = 0      -- el tiempo que está durante la partida actual (inicialmente es cero y el código automáticamente actualiza este valor)
            tiempo_creacion_siguiente_obstaculo = 0   -- siguiente momento en el que se creará un obstáculo
            obstaculos = {}    -- inicialmente no hay obstáculos creados (se crearán automáticamente cada cierto tiempo)
            tiempo_minimo_entre_obstaculos = 0.7 -- en segundos
            tiempo_maximo_entre_obstaculos = 1.5 -- en segundos
            puntos = 0
            -- fin inicialización partida
        end
    end
}

return menu
